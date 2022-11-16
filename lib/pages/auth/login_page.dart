import 'dart:convert';
import 'package:farmers_directory/pages/auth/signup_page.dart';
import 'package:farmers_directory/pages/home/main_user_page.dart';
import 'package:farmers_directory/services/network_handler_service.dart';
import 'package:farmers_directory/services/secure_store_service.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:farmers_directory/widgets/text_field.dart';
import 'package:flutter/material.dart';

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
  final User user = User(address: {"street": "", "city": "", "parish": ""});
  bool _loading = false;
  submitLogin() async {
    Map body = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    try {
      setState(() {
        _loading = true;
      });
      String authenticatedUser =
          await NetworkHandler.post("/users/login", body);
      getUserData(authenticatedUser);
    } catch (err) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }

  void getUserData(String responseString) {
    Map<String, dynamic> responseMap = jsonDecode(responseString);
    print(responseMap["data"]["token"]);
    SecureStore.storeToken("jwt-auth", responseMap["data"]["token"]);
    SecureStore.createUser(responseMap["data"]["user"]);
    Future.delayed(Duration.zero, () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  void initState() {
    SecureStore.logout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: (!_loading)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/logo.png',
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                LargeText(
                  text: 'J Farmers',
                  size: 25,
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                SmallText(
                  text: 'Get connected with local farmers',
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomTextField(
                          controller: emailController,
                          title: 'Your email address',
                          placeholder: 'johntravolta@gmail.com',
                        ),
                        CustomTextField(
                          isPassword: true,
                          controller: passwordController,
                          title: 'Password',
                          placeholder: '************',
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          height: 55,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.mainGreen,
                              shape: StadiumBorder(),
                            ),
                            onPressed: () {
                              print(emailController.text);
                              submitLogin();
                            },
                            child: LargeText(
                              text: 'Continue',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SmallText(
                              text: 'Forgot Password?',
                              color: Colors.blueAccent,
                            ),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(child: Divider()),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width10),
                                child: LargeText(text: 'OR'),
                              ),
                              Expanded(child: Divider()),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 35,
                              child: Image.asset(
                                'assets/icons/google.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            SizedBox(
                                width: Dimensions.width30,
                                child: Image.asset(
                                  'assets/icons/facebook.png',
                                  fit: BoxFit.cover,
                                )),
                          ],
                        ),
                        SizedBox(height:40),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                              SmallText(
                                text: 'Don\'t have an account as yet?',
                                color: Colors.grey,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Text('Sign Up',
                                    style: TextStyle(fontSize: 16, color:Colors.lightGreen,fontWeight: FontWeight.bold)
                                  ),
                                ),
                              )
                            ]
                          ),

                      ],
                    ),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

Widget showError(message, state, updateState, submitFunc, context) {
  return Center(
      child: AlertDialog(
    title: Text("An Error occured"),
    icon: const Icon(Icons.cancel_outlined, size: 45.0, color: Colors.red),
    content: Text(message.toString()),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    actions: [
      TextButton(
          onPressed: () {
            updateState(() {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            });
          },
          child: Text("Cancel")),
      TextButton(
          onPressed: () {
            updateState(() {
              state = submitFunc();
            });
          },
          child: Text("Retry")),
    ],
  ));
}
