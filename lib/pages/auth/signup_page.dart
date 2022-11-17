import 'package:farmers_directory/pages/auth/login_page.dart';
import 'package:farmers_directory/services/network_handler_service.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../models/user.model.dart';
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
  final TextEditingController first_nameCtrl = TextEditingController();
  final TextEditingController last_nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController password2Ctrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController streetCtrl = TextEditingController();
  final TextEditingController parishCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController websiteCtrl = TextEditingController();
  final TextEditingController instagramCtrl = TextEditingController();
  final TextEditingController facebookCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();
  bool isLastStep = false;
  bool _loading = false;



  submitSignUp()async{
    Map userBody = {
      "first_name":first_nameCtrl.text,
      "last_name":last_nameCtrl.text,
      "email":emailCtrl.text,
      "address":{
        "street": streetCtrl.text,
        "parish": parishCtrl.text,
        "city": cityCtrl.text
      },
      "phone":phoneCtrl.text,
      "password":passwordCtrl.text,
    };

    try{
        setState(() {
          _loading = true;
        });
        await NetworkHandler.post("/users", userBody);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => LoginPage()));

    }catch(error){
      setState(() {
        _loading = false;
      });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
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
      body: (!_loading) ? Stepper(
        controlsBuilder: (context, steps){
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: isLastStep ? Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.mainGreen,
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      submitSignUp();
                    },
                    child: LargeText(
                      text: 'Submit',
                      color: Colors.white,
                    ),
                  ),
                  TextButton(onPressed: steps.onStepCancel, child: const Text("Cancel", style: TextStyle(color: Colors.white70),))
                ],
              ) : Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.mainGreen,
                      shape: StadiumBorder(),
                    ),
                    onPressed: steps.onStepContinue,
                    child: LargeText(
                      text: 'Next',
                      color: Colors.white,
                    ),
                  ),
                  TextButton(onPressed: steps.onStepCancel, child: const Text("Cancel", style: TextStyle(color: AppColors.mainGreen),))
                ],
              )
          );
        },

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
          if (_index <= 0 ) {
            _index += 1;
          }
          if(_index == 1){
            isLastStep = true;

          }
          setState(() {});

        },
        onStepTapped: (int index) {
          if(index != 1){
            isLastStep = false;
          }else{
            isLastStep = true;
          }
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
                        controller: first_nameCtrl,
                        title: 'First Name',
                        placeholder: 'John',
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.7,
                      child: CustomTextField(
                        controller: last_nameCtrl,
                        title: 'Last Name',
                        placeholder: 'Travolta',
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  controller: emailCtrl,
                  title: 'Your email address',
                  placeholder: 'johntravolta@gmail.com',
                ),
                CustomTextField(
                  controller: passwordCtrl,
                  isPassword: true,
                  title: 'Password',
                  placeholder: '************',
                ),
                CustomTextField(
                  controller: password2Ctrl,
                  isPassword: true,
                  title: 'Confirm Password',
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
                      controller: streetCtrl,
                      title: 'Street ',
                      placeholder: '',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.7,
                          child: CustomTextField(
                            controller: parishCtrl,
                            title: 'Parish',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.7,
                          child: CustomTextField(
                            controller: cityCtrl,
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
        ],
    ) : Center(child:CircularProgressIndicator(color:AppColors.mainGreen)),
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