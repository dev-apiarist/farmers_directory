import 'package:dots_indicator/dots_indicator.dart';
import 'package:farmers_directory/navigation/categories_page.dart';
import 'package:farmers_directory/pages/users/details/farmer_details.dart';
import 'package:farmers_directory/pages/users/details/produce_details.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/widgets/custom_dropdown.dart';
import 'package:farmers_directory/widgets/leading_icon.dart';
import 'package:farmers_directory/widgets/produce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../utils/dimensions.dart';
import '../../utils/search.dart';
import '../../widgets/lg_text.dart';
import '../../widgets/sm_text.dart';

class MainUserPage extends StatefulWidget {
  const MainUserPage({super.key});

  @override
  State<MainUserPage> createState() => _MainUserPageState();
}

class _MainUserPageState extends State<MainUserPage> {
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
    final List<String> imageUrls = [
      'https://religionnews.com/wp-content/uploads/2021/08/Busisiwe-Mgangxela-seed-saver-and-agroecologist-from-the-Eastern-Cape-scaled-1.jpeg',
      'https://pbs.twimg.com/media/DYQsObjXUAID31O.jpg',
      'https://i2.wp.com/www.largeup.com/wp-content/uploads/2017/03/birdheye-view-all-peoples-medicine-38-b.jpg?fit=1200%2C800&ssl=1&w=640'
    ];

    final List<Map<String, String>> categories = [
      {'categoryName': 'Fruits', "categoryImg": "assets/images/fruits.png"},
      {
        'categoryName': 'Vegetables',
        "categoryImg": "assets/images/vegetables.png"
      },
      {
        'categoryName': 'Livestock',
        "categoryImg": "assets/images/livestock.png"
      },
    ];

    List<String> locations = [
      'Clarendon',
      'Kingston',
      'St. Ann',
      'St. James',
      'Portland',
      'St. Mary',
      'St. Catherine',
      'Trelawny',
    ];
    String? selectedLocation;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: SizedBox(
                width: 70,
                child: Image.asset(
                  'assets/icons/logo.png',
                  fit: BoxFit.cover,
                )),
            foregroundColor: Colors.black,
            pinned: true,
            floating: true,
            titleSpacing: 15,
            toolbarHeight: 70,
            collapsedHeight: 75,
            actions: [
              // IconButton(
              //   onPressed: () {
              //     showSearch(
              //       context: context,
              //       delegate: CustomSearchDelegate(),
              //     );
              //   },
              //   icon: Icon(Icons.search),
              // ),
            ],
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 15.0,
                        ),
                        child: CircleAvatar(
                            backgroundColor: Colors.white54,
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/profile.jpg')),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(

                              // borderSide: BorderSide(color: Colors.transparent),
                              ),
                          border: OutlineInputBorder(
                            // borderSide:
                            // BorderSide(width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search ',
                          fillColor: Colors.white,
                          filled: true),
                      readOnly: true,
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate:
                              CustomSearchDelegate(searchTerms: locations),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            expandedHeight: 140,
            elevation: 1,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.only(
            //     bottomRight: Radius.circular(10),
            //     bottomLeft: Radius.circular(10),
            //   ),
            // ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  color: AppColors.mainGreen.withOpacity(0.3),
                  margin: EdgeInsets.only(top: Dimensions.height20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: categories.map(
                      (Map<String, String> e) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 100,
                              child: Image.asset(
                                e['categoryImg']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SmallText(
                              color: Colors.black87,
                              text: e['categoryName']!,
                            )
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LargeText(
                            text: 'In Season',
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 290,
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
                          color: Colors.black12, // Inactive
                          size: const Size.square(9.0),
                          activeColor: AppColors.mainGreen),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: Dimensions.width10),
                          child: LargeText(
                            text: 'Nearby Farmers',
                            size: Dimensions.font17,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return FarmerDetails();
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: Dimensions.height10,
                            bottom: Dimensions.height20),
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10),
                        height: 200,
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  right: Dimensions.width10,
                                  top: Dimensions.height10),
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(imageUrls[index]),
                                    fit: BoxFit.cover),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<String> locations = [
    'Clarendon',
    'Kingston',
    'St. Ann',
    'St. James',
    'Portland',
    'St. Mary',
    'St. Catherine',
    'Trelawny',
    // 'Westmoreland',
    // 'St.Thomas',
    // 'Hanover',
    // 'Westmoreland',
    // 'St.Thomas',
    // 'Hanover',
  ];
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
            height: 270,
            // height: Dimensions.pageView,
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.width15),
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 5.0,
                color: Color(0xFFF4F4F4),
              ),
            ], borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Row(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: double.maxFinite,
                child: Image.network(
                  'https://ychef.files.bbci.co.uk/976x549/p099bkjt.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10,
                      vertical: Dimensions.height15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LargeText(
                        text: 'Ackee',
                        size: Dimensions.height20,
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      LargeText(
                        text: "Regions:",
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GridView.builder(
                        itemCount: locations.length,
                        itemBuilder: (context, index) => SizedBox(
                          height: 4,
                          child: SmallText(
                            text: locations[index],
                          ),
                        ),
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 0,
                            mainAxisExtent: 24,
                            crossAxisCount: 2,
                            childAspectRatio: 3,
                            crossAxisSpacing: 10),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black87,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return ProduceDetails();
                              }),
                            );
                          },
                          child: SmallText(
                            text: "View Farmers",
                            color: Colors.white,
                          ),
                        ),
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
