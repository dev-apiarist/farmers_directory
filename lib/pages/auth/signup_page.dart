import 'package:farmers_directory/pages/auth/login_page.dart';
import 'package:farmers_directory/services/network_handler_service.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../models/user.model.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final User user = User(address:{"city": "", "street":"", "parish": ""});
  Map _requestState = {
    "hasError" : false,
    "message": "",
    "pending": false,
  };




  submitSignUp()async{
    Map body = {
      "first_name":user.first_name,
      "last_name":user.last_name,
      "email":user.email,
      "address":user.address,
      "phone":user.phone,
      "password":user.password,
    };
    try{
      setState(() {
        _requestState["pending"] = true;
      });
      String dataString = await NetworkHandler.post("/users", body);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => LoginPage()));
    }catch(error){
      setState(() {
        _requestState["pending"] = false;
        _requestState["hasError"] = true;
        _requestState["message"] = error.toString();
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (_requestState["pending"])? Center(child: CircularProgressIndicator()) : (_requestState["hasError"]) ? showError(_requestState, setState, submitSignUp): Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Container(
              child: Image.asset('assets/images/logo.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "First Name"),
                    onChanged: (value){
                      setState(() {
                        user.first_name = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                      decoration: InputDecoration(labelText: "Last Name"),
                      onChanged: (value){
                        setState(() {
                          user.last_name = value;
                        });
                      }
                  ),
                ),
              ],
            ),
            TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                onChanged: (value){
                  setState(() {
                    user.email = value;
                  });
                }
            ),
            TextFormField(
                decoration: InputDecoration(labelText: "Street Address"),
                onChanged: (value){
                  setState(() {
                    user.address["street"] = value;
                    print(user.address["street"]);
                  });
                }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                      decoration: InputDecoration(labelText: "Parish"),
                      onChanged: (value) {
                        setState(() {
                          user.address["parish"] = value;
                        });
                      }
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                      decoration: InputDecoration(labelText: "City"),
                      onChanged: (value) {
                        setState(() {
                          user.address["city"] = value;
                        });
                      }
                  ),
                ),
              ],
            ),
            TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                onChanged: (value) {
                  setState(() {
                    user.password = value;
                  });
                }
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LargeText(text: 'Sign Up'),
                SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                  onPressed: () {
                    submitSignUp();
                  },
                  child: Icon(
                    Icons.arrow_forward,
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
    );
  }
}


Widget showError(state, updateState, submitSignUp){

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
              submitSignUp();
              updateState((){
                  state["hasError"] = false;
                  state["pending"] = true;
              });
            }, child: Text("Retry")),
          ],
        )
    );
}