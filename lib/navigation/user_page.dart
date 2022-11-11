import 'package:farmers_directory/pages/auth/login_page.dart';
import 'package:farmers_directory/utils/dimensions.dart';

import 'package:flutter/material.dart';

import '../pages/edit/edit_profile.dart';
import '../utils/colors.dart';
import '../widgets/leading_icon.dart';
import '../widgets/text.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

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
                builder: ((context) => LoginPage()),
              ),
            ),
            icon: Icon(
              Icons.logout,
              color: Colors.black87,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: Dimensions.height40),
            child: Column(
              children: [
                CircleAvatar(
                  radius: Dimensions.radius60,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                  backgroundColor: Colors.white60,
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                LargeText(
                  text: "John Brown",
                  size: Dimensions.height20,
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                LeadingIconText(
                  text: 'Kingston',
                  icon: Icons.location_on,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LargeText(text: 'Produce'),
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    Row(
                      children: [
                        LargeText(text: 'Crops:'),
                        Wrap(
                          children: List.generate(
                            5,
                            (index) => SmallText(text: 'Yam' ','),
                          ).toList(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      children: [
                        LargeText(text: 'Livestock:'),
                        Wrap(
                          children: List.generate(
                            2,
                            (index) => SmallText(text: 'Goat' ','),
                          ).toList(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    LargeText(text: 'About'),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    SmallText(
                        text:
                            'Expert farmer. Ensuring we Grow, smart, Eat smart. Supplying a better jamaica'),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    LeadingIconText(text: '+1 876 567-7662', icon: Icons.call),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    LeadingIconText(
                        text: 'rchydroponics11@gmail.com', icon: Icons.email),
                    SizedBox(
                      height: Dimensions.height40,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: AppColors.mainBlue),
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
          ),
        ],
      ),
    );
  }
}
