import 'dart:convert';
import 'package:farmers_directory/pages/auth/farmer_sign_up.dart';
import 'package:farmers_directory/pages/auth/signup_page.dart';
import 'package:farmers_directory/pages/home/main_user_page.dart';
import 'package:farmers_directory/pages/welcome_page.dart';
import 'package:farmers_directory/services/network_handler_service.dart';
import 'package:farmers_directory/services/secure_store_service.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:farmers_directory/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user.model.dart';
import '../../navigation/home_page.dart';

class FarmerLoginPage extends StatefulWidget {
  const FarmerLoginPage({super.key});

  @override
  State<FarmerLoginPage> createState() => _FarmerLoginPageState();
}

class _FarmerLoginPageState extends State<FarmerLoginPage> {
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
          await NetworkHandler.post("/farmers/login", body);
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
    SecureStore.storeToken("jwt-auth", responseMap["data"]["token"]);
    Map<String, dynamic> user = responseMap["data"]["data"];
    user["isFarmer"] = true;
    SecureStore.createUser(user);
    Future.delayed(Duration.zero, () {
      Get.off(() => const HomePage());
    });
  }

  @override
  void initState() {
    SecureStore.logout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: (!_loading)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimensions.logoS,
                    width: Dimensions.logoS,
                    child: Image.asset(
                      'assets/icons/logo.png',
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  const LargeText(
                      align: TextAlign.center,
                      color: AppColors.mainGold,
                      text:
                          'Let us be the platform you need to showcase your produce.'),
                  SizedBox(
                    height: Dimensions.height40,
                  ),
                  Text(
                    "Farmer Login",
                    style: TextStyle(
                        color: AppColors.mainGold,
                        fontSize: Dimensions.font27,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.width40),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomTextField(
                            controller: emailController,
                            title: 'Email address',
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
                            height: Dimensions.height50,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.mainGold,
                                shape: const StadiumBorder(),
                              ),
                              onPressed: () {
                                // print(emailController.text);
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
                          const Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: SmallText(
                              text: 'Forgot Password?',
                              color: Colors.blueAccent,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.width30),
                            child: Row(
                              children: <Widget>[
                                const Expanded(child: Divider()),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width10),
                                  child: const LargeText(text: 'OR'),
                                ),
                                const Expanded(child: Divider()),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: Dimensions.width30,
                                child: Image.asset(
                                  'assets/icons/google.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.width30,
                              ),
                              SizedBox(
                                  width: Dimensions.width30,
                                  child: Image.asset(
                                    'assets/icons/facebook.png',
                                    fit: BoxFit.cover,
                                  )),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Dimensions.height40),
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => Get.to(() => FarmerSignUpPage()),
                              child: RichText(
                                text: const TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(color: Colors.grey),
                                  children: [
                                    TextSpan(
                                      text: 'Sign Up',
                                      style: TextStyle(
                                        color: AppColors.mainGold,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

Widget showError(message, state, updateState, submitFunc, context) {
  return Center(
      child: AlertDialog(
    title: const LargeText(text: "An Error occured"),
    icon: Icon(Icons.cancel_outlined,
        size: Dimensions.height40, color: Colors.red),
    content: Text(message.toString()),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.height10)),
    actions: [
      TextButton(
          onPressed: () {
            updateState(() {
              Get.off(() => const WelcomePage());
            });
          },
          child: const SmallText(
            text: 'Cancel',
          )),
      TextButton(
          onPressed: () {
            updateState(() {
              state = submitFunc();
            });
          },
          child: const SmallText(
            text: 'Retry',
          )),
    ],
  ));
}
