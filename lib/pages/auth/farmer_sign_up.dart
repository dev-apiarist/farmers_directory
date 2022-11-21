import 'dart:convert';

import 'package:farmers_directory/models/product.model.dart';
import 'package:farmers_directory/pages/auth/login_page.dart';
import 'package:farmers_directory/services/network_handler_service.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../models/category.model.dart';
import '../../models/parishes.dart';
import '../../models/user.model.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
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
  bool isLastStep = false;
  int _currentStep = 0;
  bool _loading = false;
  List<String> selectedProduct = [];
  late Future<List<Product>> allProducts;
  late List<Category> allCategories = [];
  Color selectedColor = AppColors.mainGold.withOpacity(0.4);


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

  Future<List<Product>> getAllProducts() async{
    try{
      allCategories = await getAllCategories();

      List productList = jsonDecode(await NetworkHandler.get(endpoint: "/products"))["data"];
      setState((){});

      return productList.map((product){
        return Product.fromJson(product);
      }).toList();
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
      return [];

    }
  }
  Future<List<Category>> getAllCategories() async{
    try{
      List categoryList = jsonDecode(await NetworkHandler.get(endpoint: "/categories"))["data"];
      print(categoryList);
      return categoryList.map((category){
        return Category.fromJson(category);
      }).toList();
    }catch(error){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
      return [];

    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parishCtrl.text = parishList[0];
    allProducts = getAllProducts();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: (!_loading)?
      FutureBuilder<List<Product>>(
          future: allProducts,
          builder: (context, snapshot) {

          if(snapshot.hasData){
            return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                            height: 30
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:40.0),
                          child: Text("Create a Farmer's Account", style: TextStyle(color: AppColors.mainGold, fontWeight: FontWeight.w600, fontSize: 25),),
                        ),
                        Stepper(
                          physics:ScrollPhysics(),
                          controlsBuilder: (context, steps){
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: isLastStep ? Row(
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppColors.mainGold,
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
                                    TextButton(onPressed: steps.onStepCancel, child: const Text("Cancel", style: TextStyle(color: AppColors.mainGold),))
                                  ],
                                ) : Row(
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppColors.mainGold,
                                        shape: StadiumBorder(),
                                      ),
                                      onPressed: steps.onStepContinue,
                                      child: LargeText(
                                        text: 'Next',
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextButton(onPressed: steps.onStepCancel, child: const Text("Cancel", style: TextStyle(color: AppColors.mainGold),))
                                  ],
                                )
                            );
                          },
                          currentStep: _currentStep,
                          onStepCancel: () {
                            if (_currentStep > 0) {
                              setState(() {
                                _currentStep -= 1;
                              });
                            }
                          },
                          onStepContinue: () {
                            if (_currentStep <= 4) {
                              setState(() {
                                _currentStep += 1;
                              });
                            }
                          },
                          onStepTapped: (int index) {

                            setState(() {
                              _currentStep = index;
                            });
                          },
                          steps: [
                            Step(
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 0 ?
                              StepState.complete : StepState.disabled,
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
                                    title: 'Email',
                                    placeholder: 'johntravolta@gmail.com',
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
                                            contentPadding: EdgeInsets.all(15),
                                            hintText: "Description",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(30)),
                                            filled: true,
                                            fillColor: Colors.white70),

                                      ),
                                    ],
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

                              isActive: _currentStep >= 0,
                              state: _currentStep >= 1 ?
                              StepState.complete : StepState.disabled,
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
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Parish"),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(

                                                  height: 50,
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30),
                                                      color: Colors.white,
                                                      border: Border.fromBorderSide(BorderSide(color:Colors.grey.withOpacity(0.4), width: 1.0))
                                                  ),
                                                  child: DropdownButton(
                                                    value: parishCtrl.text,
                                                    onChanged: (String? value){
                                                      setState(() {
                                                        parishCtrl.text = value!;
                                                      });
                                                    },
                                                    borderRadius: BorderRadius.circular(10),
                                                    underline: SizedBox.shrink(),
                                                    items: parishList.map((parishName){
                                                      return DropdownMenuItem<String>(

                                                          child: Text(parishName, style: TextStyle(fontSize: 14),),
                                                          value: parishName
                                                      );

                                                    }).toList(),

                                                  ),
                                                ),
                                              ],
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
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 2 ?
                              StepState.complete : StepState.disabled,
                              title: SmallText(text: 'Socials (Optional)'),
                              content: Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextField(
                                        controller: instagramCtrl,
                                        title: 'Instagram ',
                                        placeholder: '',
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 2.7,
                                            child: CustomTextField(
                                              controller: facebookCtrl,
                                              title: 'Facebook ',
                                              placeholder: '',
                                            ),
                                          ),

                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 2.7,
                                            child: CustomTextField(
                                              controller: websiteCtrl,
                                              title: 'Website',
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
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 3 ?
                              StepState.complete : StepState.disabled,
                              title: SmallText(text: 'Select Products'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: allCategories.map((category){
                                  List<Product> filteredList = snapshot.data!.where((product) => product.category == category.id ).toList();

                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(category.category_name, style:TextStyle(fontWeight: FontWeight.w600)),
                                      ),
                                      Wrap(
                                        spacing: Dimensions.width5,
                                        children:
                                        List.generate(filteredList.length, (index) {
                                          return GestureDetector(
                                            onTap: (() {
                                                 toggleSelectedToList(productList: selectedProduct, productId: filteredList[index].id);
                                                 setState(() {});
                                            }),
                                            child: Chip(
                                              backgroundColor: isSelected(productList:selectedProduct, productId: filteredList[index].id) ? selectedColor: Colors.white,
                                              side: BorderSide(color: Colors.black54),
                                              label: SmallText(
                                                size: 13,
                                                text: '${filteredList[index].prod_name}',
                                              ),
                                            ),
                                          );
                                        }),
                                      ),

                                    ]
                                  );


                                }).toList(),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          SmallText(
                            text: 'Already have an account?',
                            color: Colors.grey,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Sign In',
                                  style: TextStyle(fontSize: 14, color:AppColors.mainGold,fontWeight: FontWeight.bold)
                              ),
                            ),
                          )
                        ]
                    ),
                  ),


                ]
            );
          }else if(snapshot.hasError){
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
            return Text(snapshot.error.toString());

          }else{
            return Center(child:CircularProgressIndicator(color: AppColors.mainGold));
          }
        }
      ) : Center(child:CircularProgressIndicator(color: AppColors.mainGold)),
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

isSelected({List productList = const[], String productId = ""}){
  return productList.contains(productId);
}

toggleSelectedToList({List productList = const[], String productId = ""}){
  if(isSelected(productList:productList, productId: productId)){
    productList.removeWhere((element) => element == productId);
  }else{productList.add(productId);}
}

