import 'package:farmers_directory/navigation/categories_page.dart';
import 'package:farmers_directory/navigation/directory_page.dart';
import 'package:farmers_directory/navigation/user_page.dart';
import 'package:farmers_directory/pages/home/main_user_page.dart';
import 'package:farmers_directory/services/secure_store_service.dart';
import 'package:farmers_directory/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/user.model.dart';
import '../pages/users/details/farmer_details.dart';
import '../pages/users/details/produce_details.dart';
import '../utils/colors.dart';
import '../widgets/leading_icon.dart';
import 'farmer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFarmer = false;
  late List pages = List.filled(4, SizedBox.shrink());

  Future<Widget> getProfilePage() async {
    User user = await SecureStore.getUser();

    if (user.isFarmer) {
      return FarmerProfile();
    } else
      return UserProfile();
  }

  void setPages() async {
    pages = [MainUserPage(), Directory(), Categories(), await getProfilePage()];
    setState(() {});
  }

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setPages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.width20, vertical: Dimensions.height10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BottomNavigationBar(
            // unselectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            onTap: onTap,
            currentIndex: currentIndex,
            elevation: 1,
            selectedItemColor: AppColors.mainGreen,
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.book), label: 'Directory'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view), label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
