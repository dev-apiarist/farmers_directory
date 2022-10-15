import 'package:farmers_directory/pages/details/farmer_details.dart';
import 'package:farmers_directory/pages/details/featured_produce_details.dart';
import 'package:farmers_directory/pages/home/produce_page_body.dart';
import 'package:flutter/material.dart';
import 'package:farmers_directory/pages/home/main_farmer_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'Josefin Sans'),
      debugShowCheckedModeBanner: false,
      home: MainFarmerPage(),
    );
  }
}
