import 'dart:convert';

import 'package:farmers_directory/pages/auth/signup_page.dart';
import 'package:farmers_directory/pages/home/main_user_page.dart';
import 'package:farmers_directory/services/network_handler_service.dart';
import 'package:farmers_directory/services/secure_store_service.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../models/user.model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});




  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final User user = User(address: {"street": "", "city": "", "parish":""});

  Map _requestState = {
    "hasError" : false,
    "message": "",
    "pending": false,
  };

  submitLogin() async{
    Map body ={
      "email": user.email,
      "password": user.password,
    };
    try{
      setState(() {
      _requestState["pending"] = true;
      });
      String responseString = await NetworkHandler.post("/users/login", body);
      Map<String, dynamic> responseMap = jsonDecode(responseString);
      SecureStore.storeToken("jwt-auth", responseMap["data"]["token"]);
      SecureStore.createUser(responseMap["data"]["user"]);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MainUserPage()));

    }catch(error){
      setState(() {
        _requestState["pending"] = false;
        _requestState["hasError"] = true;
        _requestState["message"] = error.toString();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_requestState["pending"]) ? Center(child: CircularProgressIndicator()): (_requestState["hasError"])? showError(_requestState, setState, submitLogin) : Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: ((value) {
                if (value!.isEmpty || RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                  return "Enter valid email";
                }
              }),
              onChanged: (value){
                setState(() {
                  user.email = value;
                });
              },
              decoration: InputDecoration(labelText: 'Email', helperText: " "),
            ),
            TextFormField(
              obscureText: true,
              onChanged: (value){
                setState(() {
                  user.password = value;
                });
              },
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.black87,
                ),
                onPressed: () {
                    submitLogin();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: LargeText(
                    text: 'Sign In',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget showError(state, updateState, submitFunc){

  return Center(
      child: AlertDialog(
        title: Text("Signup Failed!"),
        icon: const Icon(Icons.cancel_outlined, size: 45.0, color: Colors.red),
        content: Text(state["message"].toString()),
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(10.0))),

        actions: [
          TextButton(onPressed: (){
            updateState((){
              state["hasError"] = false;
            });
          }, child: Text("Cancel")),

          TextButton(onPressed: (){
            submitFunc();
            updateState((){
              state["hasError"] = false;
              state["pending"] = true;
            });
          }, child: Text("Retry")),
        ],
      )
  );
}
