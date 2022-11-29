
import 'dart:convert';
import 'dart:io';

import 'package:farmers_directory/pages/edit/edit_password.dart';
import 'package:farmers_directory/pages/edit/personal_information_page.dart';
import 'package:farmers_directory/pages/farmer/main_farmer_page.dart';
import 'package:farmers_directory/services/network_handler_service.dart';
import 'package:farmers_directory/services/secure_store_service.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/utils/functions.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/farmer.model.dart';
import '../../models/user.model.dart';

class EditFarmerProfilePage extends StatefulWidget {
  const EditFarmerProfilePage({super.key});

  @override
  State<EditFarmerProfilePage> createState() => _EditFarmerProfilePageState();
}

class _EditFarmerProfilePageState extends State<EditFarmerProfilePage> {
  late Future<User> user;
  ImagePicker _imagePicker = ImagePicker();
  XFile? imgChosen;
  String imageUrl = "";
  List<String> productList = [];


  TextEditingController fnameCtrl = TextEditingController();
  TextEditingController lnameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();

  String id = "";
  bool _loading = false;
  submitData()async{
      Map<String, String> body = {
        "first_name": fnameCtrl.text,
        "last_name": lnameCtrl.text,
        "email": emailCtrl.text,
        "phone": phoneCtrl.text,
        "description": descriptionCtrl.text,
        "products": jsonEncode(productList),
      };
      List<Map<String, dynamic>> files = [
        {"field": "image", "data": imgChosen}
      ];
       try{
      _loading = true;
      Map responseData = jsonDecode(await NetworkHandler.patchMultipart("/farmers/${id}", body, files));
      SecureStore.createUser(responseData["data"]);
      Navigator.pop(context, true);
      }catch(error) {
        setState((){
          _loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
      }

  }

  Future<User> getUser() async {
    User currentUser = await SecureStore.getUser();
    id = currentUser.id;
    if(currentUser.isFarmer){
      Map<String, dynamic>farmerData = jsonDecode(await NetworkHandler.get(endpoint: "/farmers/${currentUser.id}"))["data"];
      return Farmer.fromJson(farmerData);
    }
    return currentUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              submitData();
            },
            icon: Icon(
              Icons.done,
              color: Colors.black87,
            ),
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: (!_loading) ? FutureBuilder(
        future: user,
        builder: (context, snapshot) {

          if(snapshot.hasData){
            Farmer farmer = (snapshot.data! as Farmer);
            emailCtrl.text = snapshot.data!.email;
            fnameCtrl.text = snapshot.data!.first_name;
            lnameCtrl.text = snapshot.data!.last_name;
            phoneCtrl.text = snapshot.data!.phone;
            descriptionCtrl.text = (snapshot.data! as Farmer).description;
            productList = (snapshot.data! as Farmer).products.map((e) => e.id).toList();


            imageUrl = snapshot.data!.image;
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap:()async{
                              var data = await _imagePicker.pickImage(source: ImageSource.gallery);
                              setState(() {
                                imgChosen = data;

                              });
                            },
                            child: CircleAvatar(
                            radius: 70,
                            backgroundImage: displayUploadedImage(imageUrl, imgChosen),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          LargeText(text: 'Tap to update photo', size: 12),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: fnameCtrl,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    TextFormField(
                      controller: lnameCtrl,
                      maxLines: 1,

                      decoration: InputDecoration(

                        labelText: 'Last Name',
                      ),
                    ),

                    TextFormField(
                      controller: emailCtrl,
                      maxLines: 1,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextFormField(
                      controller: descriptionCtrl,
                      maxLines: 3,
                      minLines: 3,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    TextFormField(
                      controller: phoneCtrl,
                      maxLines: 1,
                      decoration: InputDecoration(labelText: 'Telephone'),
                    ),
                    TextFormField(
                      obscureText: true,
                      initialValue: "paswordprotected",
                      enabled: false,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => MainFarmerPage(farmer:farmer)),
                        ),
                      ).then((value){
                        //Checks if the produce list has been updated.
                        if(value is bool && value == false){
                        }else if(value is List){
                            productList = value as List<String>;
                        }
                      }),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LargeText(text: 'Update Produce'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => PersonalInformation()),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LargeText(text: 'Personal Information'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => EditPassword()),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LargeText(text: 'Security'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else{
            if(snapshot.hasError){
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          }
        }
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}


displayUploadedImage(String imageUrl, XFile? uploaded){

  if(uploaded != null){
    return FileImage(File(uploaded.path));

  }else{
    return setProfileImage(imageUrl);
  }
}