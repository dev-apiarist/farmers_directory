import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:farmers_directory/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/logo.png',
          ),
          SizedBox(
            height: 10,
          ),
          LargeText(
            text: 'J Farmers',
            size: 25,
          ),
          SizedBox(
            height: 10,
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
                    title: 'Your email address',
                    placeholder: 'johntravolta@gmail.com',
                  ),
                  CustomTextField(
                    isPassword: true,
                    title: 'Password',
                    placeholder: '************',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 55,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.mainGreen,
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {},
                      child: LargeText(
                        text: 'Continue',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SmallText(
                        text: 'Forgot Password?',
                        color: Colors.blueAccent,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                          width: 30,
                          child: Image.asset(
                            'assets/icons/facebook.png',
                            fit: BoxFit.cover,
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
