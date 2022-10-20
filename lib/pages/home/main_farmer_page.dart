import 'package:farmers_directory/navigation/home_page.dart';
import 'package:farmers_directory/pages/users/details/farmer_details.dart';
import 'package:farmers_directory/pages/users/details/produce_details.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          title: LargeText(text: "J Farmers"),
        ),
        drawer: Drawer(),
        body: Column(
          children: [
            // Container(
            //   color: AppColors.mainGreen,
            //   padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
            //   child: SizedBox(
            //     width: double.maxFinite,
            //     height: 60,
            //     child: Image(
            //       alignment: Alignment.topLeft,
            //       image: AssetImage('assets/images/logo.png'),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.location_on),
                          hintText: "Location"),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.search),
                          hintText: "I'm Searching for..."),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.12,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.tune),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: ProducePageBody(),
              ),
            ),
          ],
        ),
        //   bottomNavigationBar: BottomNavigationBar(
        //     type: BottomNavigationBarType.fixed,
        //     elevation: 1,
        //     // showSelectedLabels: true,
        //     // showUnselectedLabels: false,
        //     items: [
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.home_rounded),
        //         label: 'Home',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.perm_contact_cal_rounded),
        //         label: 'Farmer',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.spa_rounded),
        //         label: 'Produce',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.person),
        //         label: 'Account',
        //       ),
        //     ],
        //   ),
      ),
    );
  }
}
