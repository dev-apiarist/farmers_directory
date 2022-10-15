import 'package:farmers_directory/pages/home/produce_page_body.dart';
import 'package:farmers_directory/utils/dimensions.dart';
import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../widgets/lg_text.dart';
import '../../widgets/sm_text.dart';

class MainFarmerPage extends StatefulWidget {
  const MainFarmerPage({super.key});

  @override
  State<MainFarmerPage> createState() => _MainFarmerPageState();
}

class _MainFarmerPageState extends State<MainFarmerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.mainGreen,
              padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: SizedBox(
                width: double.maxFinite,
                height: 60,
                child: Image(
                  alignment: Alignment.topLeft,
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ProducePageBody(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 1,
          // showSelectedLabels: true,
          // showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.cabin_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_people),
              label: 'Farmer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.spa_rounded),
              label: 'Produce',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
