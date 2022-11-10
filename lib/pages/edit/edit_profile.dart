
import 'dart:io';

import 'package:farmers_directory/pages/edit/edit_password.dart';
import 'package:farmers_directory/pages/edit/personal_information_page.dart';
import 'package:farmers_directory/pages/farmer/main_farmer_page.dart';
import 'package:farmers_directory/services/secure_store_service.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/utils/functions.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user.model.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Future<User> user;
  ImagePicker _imagePicker = ImagePicker();
  XFile? imgChosen;
  String imageUrl = "";


  TextEditingController fnameCtrl = TextEditingController();
  TextEditingController lnameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();

  submitData(){

  }

  Future<User> getUser() async {
    User currentUser = await SecureStore.getUser();
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
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<User>(
        future: user,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            imageUrl = snapshot.data!.image!;
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
                      initialValue: '${snapshot.data!.first_name}',
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    TextFormField(
                      controller: lnameCtrl,
                      initialValue: snapshot.data!.last_name,
                      maxLines: 1,

                      decoration: InputDecoration(

                        labelText: 'Last Name',
                      ),
                    ),
                    TextFormField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'About',
                        labelStyle: TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    TextFormField(
                      controller: emailCtrl,
                      initialValue: snapshot.data!.email,
                      maxLines: 1,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => MainFarmerPage()),
                        ),
                      ),
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
      ),
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