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