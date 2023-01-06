import 'package:farmers_directory/pages/auth/farmer_login_page.dart';
import 'package:farmers_directory/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import '../widgets/typography.dart';
import 'auth/login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
  }

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
                      LargeText(
                        text: 'Meet Local Farmers'.toUpperCase(),
                        size: Dimensions.xxl,
                        weight: FontWeight.bold,
                      ),
                      const LargeText(
                        text:
                            "From the farm to you yaad, cut down\nthird-party costs.",
                        align: TextAlign.center,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.mainGreen,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          Get.to(
                            () => const LoginPage(),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.width10),
                          child: LargeText(
                            text: 'Get Connected',
                            color: Colors.white,
                            size: Dimensions.lg,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => const FarmerLoginPage(),
                          );
                        },
                        child: SmallText(
                            text: "Are you a farmer? ", size: Dimensions.sm),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: Dimensions.logoPos,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
              width: Dimensions.logoSize,
              height: Dimensions.logoSize,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.width5),
                child: Image.asset(
                  'assets/icons/logo.png',
                  fit: BoxFit.cover,
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
