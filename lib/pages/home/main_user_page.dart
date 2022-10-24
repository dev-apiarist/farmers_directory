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
      // drawer: Drawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2(
                      style: TextStyle(color: Colors.white),
                      dropdownElevation: 1,
                      dropdownMaxHeight: 200,
                      dropdownDecoration:
                          BoxDecoration(color: AppColors.mainBlue),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      hint: LargeText(
                        text: 'Location',
                        color: Colors.white,
                      ),
                      iconEnabledColor: Colors.white,
                      items: locations
                          .map(
                            (location) => DropdownMenuItem(
                              value: location,
                              child: LargeText(
                                text: location,
                                color: Colors.white,
                              ),
                            ),
                          )
                          .toList(),
                      value: selectedLocation,
                      onChanged: (location) {
                        setState(() {
                          selectedLocation = location as String;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            pinned: true,
            floating: true,
            titleSpacing: 15,
            toolbarHeight: 55,
            collapsedHeight: 60,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 5),
                child: CircleAvatar(
                    backgroundColor: Colors.white54,
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/profile.jpg')),
              )
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
            backgroundColor: AppColors.mainGreen,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search for Fruits, Vegetable, Livestock',
                          fillColor: Colors.white,
                          filled: true),
                      readOnly: true,
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            expandedHeight: 170,
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
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: categories.map(
                      (e) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.all(7),
                              clipBehavior: Clip.hardEdge,
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                color: AppColors.mainGreen.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(37.5),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  e.keys.elementAt(0),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // SmallText(
                            //   text: ,
                            // )
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
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
                      height: 240,
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
                        activeSize: const Size(18.0, 9.0),
                        activeColor: AppColors.mainBlue,
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LargeText(
                            text: 'Nearby Farmers',
                            size: 17,
                          ),
                        ],
                      ),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width20),
                        height: 200,
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  right: Dimensions.width15,
                                  top: Dimensions.height10),
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.height20),
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
    // 'Portland',
    // 'St. Mary',
    // 'St. Catherine',
    // 'Trelawny',
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
            // height: Dimensions.pageView,
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.width15),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 5.0,
                    color: Color(0xFFF4F4F4),
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  Dimensions.radius10,
                ),
                color: Colors.white),
            child: Row(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
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
                        text: "Regions",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1.5, left: 2),
                        child: Wrap(
                          spacing: Dimensions.width10,
                          runSpacing: 5,
                          children: List.generate(
                            locations.length,
                            (index) {
                              return LeadingIconText(
                                text: locations[index],
                                iconSize: Dimensions.height10,
                                textSize: Dimensions.height15,
                                icon: Icons.fiber_manual_record,
                                color: Colors.black87,
                              );
                            },
                          ),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.mainBlue,
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

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Apples',
    'Banana',
    'Yam',
    'Potato',
    'Tomato',
    'Lychee',
    'Orange',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var produce in searchTerms) {
      if (produce.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(produce);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var produce in searchTerms) {
      if (produce.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(produce);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
