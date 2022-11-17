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

class FarmerSignUpPage extends StatefulWidget {
  FarmerSignUpPage({super.key});
  @override
  State<FarmerSignUpPage> createState() => _FarmerSignUpPageState();
}

class _FarmerSignUpPageState extends State<FarmerSignUpPage> {
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





  submitSignUp()async{
    Map farmerBody = {
      "first_name":first_nameCtrl.text,
      "last_name":last_nameCtrl.text,
      "email":emailCtrl.text,
      "address":{
        "street": streetCtrl.text,
        "parish": parishCtrl.text,
        "city": cityCtrl.text
      },
      "phone":phoneCtrl.text,
      "description": descriptionCtrl.text,
      "password":passwordCtrl.text,
      "socials": {
        "facebook": facebookCtrl.text,
        "instagram": instagramCtrl.text,
        "website": websiteCtrl.text,
      }
    };
    try{
        String dataString = await NetworkHandler.post("/farmers", farmerBody);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder) => LoginPage()));

    }catch(error){
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(text: "Description"),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      minLines: 4,
                      maxLines: 5,
                      controller: descriptionCtrl,
                      scrollPhysics: BouncingScrollPhysics(),
                      keyboardType:TextInputType.multiline,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.4))),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Description",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          filled: true,
                          fillColor: Colors.white70),

                    ),
                  ],
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