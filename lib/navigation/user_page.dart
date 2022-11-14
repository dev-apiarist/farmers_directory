import 'package:farmers_directory/pages/auth/login_page.dart';
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

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Future<User> currentUser;

  Future<User> getCurrentUser() async {
    return SecureStore.getUser();
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
      body: FutureBuilder<User>(
        future: currentUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
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
                        height: 10,
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
                        icon: Icons.location_on,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        // LargeText(text: 'Produce'),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        // Row(
                        //   children: [
                        //     LargeText(text: 'Crops:'),
                        //     Wrap(
                        //       children: List.generate(
                        //         5,
                        //             (index) => SmallText(text: 'Yam' ','),
                        //       ).toList(),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     LargeText(text: 'Livestock:'),
                        //     Wrap(
                        //       children: List.generate(
                        //         2,
                        //             (index) => SmallText(text: 'Goat' ','),
                        //       ).toList(),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        LeadingIconText(
                            text: '${snapshot.data!.phone}', icon: Icons.call),
                        SizedBox(
                          height: 20,
                        ),
                        LeadingIconText(
                            text: '${snapshot.data!.email}', icon: Icons.email),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: AppColors.mainGreen),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return EditProfilePage();
                                  },
                                ),
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
          }
        },
      ),
    );
  }
}
