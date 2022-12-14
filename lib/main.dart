import 'package:farmers_directory/pages/welcome_page.dart';
import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  GlobalFunctions();
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
      theme: ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          toolbarHeight: 65,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const WelcomePage(),
        ),
      ],
    );
  }
}
