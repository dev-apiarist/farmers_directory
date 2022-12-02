import 'package:farmers_directory/pages/auth/farmer_login_page.dart';

import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/widgets/lg_text.dart';

import 'package:flutter/material.dart';

import 'auth/login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              ClipPath(
                clipper: CustomClip(),
                child: Container(
                  height: Dimensions.welcomePageImg,
                  decoration: const BoxDecoration(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: Dimensions.height20),
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Meet Local Farmers'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: Dimensions.font27,
                              fontWeight: FontWeight.w800),
                          children: [
                            // TextSpan(
                            //     text: '\nWith Real Farmers'.toUpperCase(),
                            //     style: TextStyle(fontSize: 20)),
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
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.height15,
                              horizontal: Dimensions.width15),
                          child: LargeText(
                            text: 'Get Connected',
                            color: Colors.white,
                            size: Dimensions.height20,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FarmerLoginPage()));
                        },
                        child: Text(
                          "Are you a farmer? ",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: Dimensions.height15),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: Dimensions.logoPos,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimensions.radius50),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
                width: Dimensions.logoS,
                height: Dimensions.logoS,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.width5),
                  child: Image.asset(
                    'assets/icons/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
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
