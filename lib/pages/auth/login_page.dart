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
import '../../navigation/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});




  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final User user = User(address: {"street": "", "city": "", "parish":""});
  Future<String>? authenticateUser;

  submitLogin(snapshot){
      Map body ={
        "email": emailController.text,
        "password": passwordController.text,
      };
        setState(() {
          authenticateUser = NetworkHandler.post("/users/login", body);
        });
      }



  Widget buildForm(AsyncSnapshot<String?> snapshot, String? error){
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (error == "null" || error == null) ? Text("") : Text(error),
            TextFormField(
              controller: emailController,
              validator: ((value) {
                if (value!.isEmpty || RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                  return "Enter valid email";
                }
              }),
              decoration: InputDecoration(labelText: 'Email', helperText: " "),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.black87,
                ),
                onPressed:(){
                  submitLogin(snapshot);
                }
                ,
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

  void getUserData(String responseString){
    Map<String, dynamic> responseMap = jsonDecode(responseString);
    SecureStore.storeToken("jwt-auth", responseMap["data"]["token"]);
    SecureStore.createUser(responseMap["data"]["user"]);
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
    });

  }


@override
  void initState() {
    // TODO: implement initState
    authenticateUser = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authenticateUser,
      builder: (context, snapshot) {
        print(snapshot);
        if(snapshot.connectionState == ConnectionState.waiting){
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) {
          getUserData(snapshot.data!);
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return buildForm(snapshot, snapshot.error.toString());
        }
      }
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


