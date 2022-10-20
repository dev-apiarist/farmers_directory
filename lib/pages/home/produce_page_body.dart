import 'package:dots_indicator/dots_indicator.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/widgets/produce.dart';
import 'package:flutter/material.dart';
import '../../utils/dimensions.dart';
import '../../widgets/lg_text.dart';
import '../../widgets/sm_text.dart';

class ProducePageBody extends StatefulWidget {
  const ProducePageBody({super.key});

  @override
  State<ProducePageBody> createState() => _ProducePageBodyState();
}

class _ProducePageBodyState extends State<ProducePageBody> {
  PageController pageController = PageController(viewportFraction: 1);

  var _currPageValue = 0.0;
  final double _scaleFactor = 0.95;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();

    pageController.addListener(
      () {
        setState(
          () {
            _currPageValue = pageController.page!;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose(); //to prevent memory leak once page changes
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          height: 150,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.perm_contact_cal_sharp),
                SizedBox(
                  height: 10,
                ),
                LargeText(text: "Farmers")
              ],
            ),
            VerticalDivider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.spa_outlined),
                SizedBox(
                  height: 10,
                ),
                LargeText(text: 'Crops')
              ],
            ),
            VerticalDivider(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.pets),
                SizedBox(
                  height: 10,
                ),
                LargeText(text: 'Livestock')
              ],
            ),
          ]),
        ),
        Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LargeText(
                      text: 'In Season',
                      size: 27,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 0, right: 30),
                height: Dimensions.pageView,
                child: PageView.builder(
                  padEnds: false,
                  controller: pageController,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, position) {
                    return _buildPageItem(position);
                  },
                ),
              ),
              DotsIndicator(
                dotsCount: 3,
                position: _currPageValue,
                decorator: DotsDecorator(
                  color: Colors.white, // Inactive
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeColor: AppColors.mainBrown,
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LargeText(
                      text: 'Nearby Farmers',
                      size: 24,
                    ),
                    SmallText(
                      size: 17,
                      text: 'View all',
                    )
                  ],
                ),
              ),
              Container(
                height: 200,
                child: Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: ((context, index) {
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        child: Stack(children: [
                          Image.network(
                            'https://i0.wp.com/www.majoronetours.com/wp-content/uploads/2022/07/E0AE08AE-A9ED-4293-8471-E8DCD90E4C10.jpeg?fit=1280%2C1280&ssl=1',
                            fit: BoxFit.cover,
                            width: 150,
                          )
                        ]),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

//pageview slider
  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();

    // if current page
    if (index == _currPageValue.floor()) {
      var currScale =
          1 - (_currPageValue - index) * (1 - _scaleFactor); //set scale to  1
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }
    //if second page
    else if (index == _currPageValue.floor() + 1) {
      var currScale = _scaleFactor +
          (_currPageValue - index + 1) * (1 - _scaleFactor); //returns 0.8
      var currTrans =
          _height * (1 - currScale) / 2; // 0.2 / 2 = 1/10 *(_height)= 22
      matrix = Matrix4.diagonal3Values(
          1, currScale, 1); //scale down to 0.8 along y-axis
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(
            0, currTrans, 0); //move down along y-axis after scale to center
    }
    //if previous to the current indexed page
    else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }
    // scale next to current indexed page to 0.8
    else {
      var currScale = 0.95;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: 20, right: 10),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 5.0,
                    color: Color.fromARGB(62, 68, 68, 68),
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  Dimensions.radius20,
                ),
                color: Colors.white),
            child: Row(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.37,
                height: double.maxFinite,
                child: Image.network(
                  'https://ychef.files.bbci.co.uk/976x549/p099bkjt.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmallText(text: 'In Season'),
                      LargeText(text: 'Ackee'),
                      LargeText(text: "Regions:"),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: LargeText(
                                text: "View Farmers",
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    // path.moveTo(0, 0);
    path.lineTo(0, h * 0.8);

    path.quadraticBezierTo(
        w * 0.5, //point 3
        h, //point 3
        w, //point 4
        h * 0.7 //point 4
        );
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
