import 'dart:convert';

import 'package:farmers_directory/models/farmer.model.dart';
import 'package:farmers_directory/pages/auth/login_page.dart';
import 'package:farmers_directory/pages/edit/edit_farmers_profile.dart';
import 'package:farmers_directory/services/network_handler_service.dart';
import 'package:farmers_directory/services/secure_store_service.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../models/user.model.dart';
import '../pages/edit/edit_profile.dart';
import '../utils/colors.dart';
import '../utils/functions.dart';
import '../widgets/leading_icon.dart';
import '../widgets/text.dart';

class FarmerProfile extends StatefulWidget {
  const FarmerProfile({super.key});

  @override
  State<FarmerProfile> createState() => _FarmerProfileState();
}

class _FarmerProfileState extends State<FarmerProfile> {
  late Future<Farmer> currentUser;

  Future<Farmer> getCurrentUser() async {
    User userData = await SecureStore.getUser();
      Map<String, dynamic> farmerData = jsonDecode(await NetworkHandler.get(endpoint: "/farmers/${userData.id}"));
      return Farmer.fromJson(farmerData["data"]);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser = getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  SecureStore.logout();
                  return LoginPage();
                },
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.black87,
            ),
          )
        ],
      ),
      body: FutureBuilder<Farmer>(
        future: currentUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if(snapshot.hasData){
            return Column(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: setProfileImage(snapshot.data!.image),
                        backgroundColor: Colors.white60,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LargeText(
                        text:
                            "${snapshot.data!.first_name} ${snapshot.data!.last_name}",
                        size: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LeadingIconText(
                        text: '${snapshot.data!.address["parish"]}',
                        icon: Icons.location_on_outlined,
                        color: Colors.black87,
                        iconSize:30
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LargeText(text: 'Produce'),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(
                                snapshot.data!.products.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                      child: Chip(label:Text('${snapshot.data!.products[index].prod_name}',), backgroundColor: AppColors.mainGold.withOpacity(0.2),),
                                    ),
                              ).toList(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        LargeText(text: 'About Us'),
                        Text("${snapshot.data!.description}", style: TextStyle(fontWeight: FontWeight.w100),),

                        SizedBox(
                          height: 20,
                        ),


                        GestureDetector(
                          onTap: (){
                            launchApplication(snapshot.data!.phone);
                          },
                          child: LeadingIconText(
                              text: '${snapshot.data!.phone}', icon: Icons.call),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: (){
                            launchApplication(snapshot.data!.email);
                          },
                          child:LeadingIconText(
                              text: '${snapshot.data!.email}', icon: Icons.email),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: AppColors.mainGold),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return EditFarmerProfilePage();
                                  },
                                ),
                              ).then((updated) {
                                if(updated){
                                  setState(() {
                                    print("I got a value");
                                    currentUser = getCurrentUser();
                                  });
                                }

                              }

                              );
                            },
                            child: LargeText(
                              text: 'Edit Profile',
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }else{
            return Text("${snapshot.error}");
          }
        },
      ),
    );
  }
}
