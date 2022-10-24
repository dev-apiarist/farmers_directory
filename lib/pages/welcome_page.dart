import 'package:farmers_directory/pages/home/main_user_page.dart';

import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../navigation/home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: CustomClip(),
            child: Container(
              height: Dimensions.welcomePageImg,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/welcome_page.jpeg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.height20),
              width: double.maxFinite,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Get Connected'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 35,
                            fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                              text: '\nWith Real Farmers'.toUpperCase(),
                              style: TextStyle(fontSize: 28)),
                        ],
                      ),
                    ),
                    LargeText(
                      text:
                          "From the farm to you yaad, cut down\nthird-party costs.",
                      align: TextAlign.center,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF8CB369),
                          shape: StadiumBorder()),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.height15,
                            horizontal: Dimensions.width15),
                        child: LargeText(
                          text: 'Get Started',
                          color: Colors.white,
                          size: Dimensions.height20,
                        ),
                      ),
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h - 100, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
