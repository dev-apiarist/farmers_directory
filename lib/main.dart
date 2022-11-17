import 'package:farmers_directory/navigation/user_page.dart';
import 'package:farmers_directory/pages/edit/edit_profile.dart';
import 'package:farmers_directory/navigation/categories_page.dart';
import 'package:farmers_directory/navigation/home_page.dart';
import 'package:farmers_directory/pages/auth/login_page.dart';
import 'package:farmers_directory/pages/auth/signup_page.dart';
import 'package:farmers_directory/pages/farmer/main_farmer_page.dart';
import 'package:farmers_directory/pages/users/details/farmer_details.dart';
import 'package:farmers_directory/pages/users/details/produce_details.dart';

import 'package:farmers_directory/pages/welcome_page.dart';

import 'package:farmers_directory/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:farmers_directory/pages/home/main_user_page.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helper/dependencies.dart' as dep;
import 'package:flutter/services.dart';

void main() async {
  GlobalFunctions();
  WidgetsFlutterBinding.ensureInitialized();

  await dep.init();
  runApp(const RootApp());
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
