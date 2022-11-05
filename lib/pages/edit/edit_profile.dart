import 'package:farmers_directory/pages/edit/edit_password.dart';
import 'package:farmers_directory/pages/edit/personal_information_page.dart';
import 'package:farmers_directory/pages/farmer/main_farmer_page.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
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
      body: SingleChildScrollView(
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
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LargeText(text: 'Change profile photo'),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'About',
                  labelStyle: TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
              TextField(
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
      ),
    );
  }
}
