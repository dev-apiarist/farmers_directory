import 'package:farmers_directory/navigation/categories_page.dart';
import 'package:farmers_directory/navigation/directory_page.dart';
import 'package:farmers_directory/navigation/user_page.dart';
import 'package:farmers_directory/pages/home/main_user_page.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../pages/users/details/farmer_details.dart';
import '../pages/users/details/produce_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [MainUserPage(), Directory(), Categories(), UserProfile()];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: pages[currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      ),
    );
  }
}
