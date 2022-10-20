import 'package:farmers_directory/pages/home/main_farmer_page.dart';
import 'package:farmers_directory/pages/home/produce_page_body.dart';
import 'package:farmers_directory/utils/colors.dart';
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
              height: MediaQuery.of(context).size.height * 0.63,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.pexels.com/photos/4177755/pexels-photo-4177755.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.maxFinite,
              child: Column(children: [
                Text(
                  'GET CONNECTED\nWITH REAL FARMERS',
                  style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.black54),
                ),
                SizedBox(
                  height: 30,
                ),
                LargeText(
                  text:
                      "From the farm to you yaad, cut down\nthird-party costs",
                  align: TextAlign.center,
                  size: 18,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 210,
                  child: TextButton(
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
                      padding: const EdgeInsets.symmetric(
                        vertical: 14.0,
                      ),
                      child: LargeText(
                        text: 'Get Started',
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(),
                    ),
                  ),
                  child: Text(
                    'Are you a farmer?',
                    style: TextStyle(fontSize: 17),
                  ),
                )
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
    path.quadraticBezierTo(w * 0.5, h - 120, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
