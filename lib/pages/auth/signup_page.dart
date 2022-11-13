import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/colors.dart';
import '../../widgets/text_field.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _index = 0;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        // type: StepperType.horizontal,
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index <= 0) {
            setState(() {
              _index += 1;
            });
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        steps: [
          Step(
            title: SmallText(text: 'Personal Details'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.7,
                      child: CustomTextField(
                        isPassword: true,
                        title: 'First Name',
                        placeholder: 'John',
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.7,
                      child: CustomTextField(
                        isPassword: true,
                        title: 'Last Name',
                        placeholder: 'Travolta',
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  title: 'Your email address',
                  placeholder: 'johntravolta@gmail.com',
                ),
                CustomTextField(
                  isPassword: true,
                  title: 'Password',
                  placeholder: '************',
                ),
              ],
            ),
          ),
          Step(
            title: SmallText(text: 'Address'),
            content: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextField(
                      title: 'Street ',
                      placeholder: '',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.7,
                          child: CustomTextField(
                            isPassword: true,
                            title: 'Parish',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.7,
                          child: CustomTextField(
                            isPassword: true,
                            title: 'City',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Step(
            title: SmallText(text: 'Socials (Optional)'),
            content: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
