import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:farmers_directory/models/category.model.dart';
import 'package:farmers_directory/navigation/categories_page.dart';
import 'package:farmers_directory/pages/auth/farmer_login_page.dart';
import 'package:farmers_directory/pages/auth/login_page.dart';
import 'package:farmers_directory/pages/users/details/farmer_details.dart';
import 'package:farmers_directory/pages/users/details/produce_details.dart';
import 'package:farmers_directory/services/network_handler_service.dart';
import 'package:farmers_directory/services/secure_store_service.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/utils/functions.dart';
import 'package:farmers_directory/widgets/custom_dropdown.dart';
import 'package:farmers_directory/widgets/leading_icon.dart';
import 'package:farmers_directory/widgets/produce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../models/farmer.model.dart';
import '../../models/product.model.dart';
import '../../models/user.model.dart';
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
  late Future<User> currentUser;
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.95;
  List<Category> categories = [];
  List<Farmer> farmers = [];
  List<Product> products = [];
  List<Farmer> nearbyFarmers = [];

  Future<List<Farmer>> getFarmers() async {
    Map<String, dynamic> response =
        jsonDecode(await NetworkHandler.get(endpoint: "/farmers"));
    List farmersList = response["data"];
    return farmersList.map((farmer) {
      return Farmer.fromJson(farmer);
    }).toList();
  }

  logout() async{
    User user = await SecureStore.getUser();
    Widget? loginPage;
    if(user.isFarmer){
      loginPage = FarmerLoginPage();
    }else{
      loginPage = LoginPage();
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> loginPage!));

  }

  Future<List<Product>> getProducts() async {
    Map<String, dynamic> response =
        jsonDecode(await NetworkHandler.get(endpoint: "/products"));
    List productsList = response["data"];
    return productsList.map((product) {
        return Product.fromJson(product);
      }).toList();
  }

  Future<List<Category>> getCategories() async {
    Map<String, dynamic> response =
        jsonDecode(await NetworkHandler.get(endpoint: "/categories"));
    List categoryList = response["data"];
      return categoryList.map((category) {
        return Category.fromJson(category);
      }).toList();
  }

  getData() async {
    try {
      farmers = await getFarmers();
      categories = await getCategories();
      products = await getProducts();
      setState(() {});
    } catch (error) {
      print(error);
    }
  }

  final double _height = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    getData();
    currentUser = SecureStore.getUser();

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
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.65,
          elevation: 0,
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: AppColors.mainGreen),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              ListTile(
                title: LeadingIconText(
                  iconSize: Dimensions.iconSize16,
                  icon: Icons.person,
                  text: 'Account',
                ),
              ),
              Divider(),
              ListTile(
                title: LeadingIconText(
                  iconSize: Dimensions.iconSize16,
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ),
              Divider(),
              ListTile(
                title: LeadingIconText(
                  iconSize: Dimensions.iconSize16,
                  icon: Icons.feedback,
                  text: 'Send Feedback',
                ),
              ),
              Divider(),
              ListTile(
                onTap: (){
                  logout();
                },
                title: LeadingIconText(
                  iconSize: Dimensions.iconSize16,
                  icon: Icons.logout,
                  text: 'Logout',
                ),
              ),
              Divider(),
            ],
          ),
        ),
        body: FutureBuilder<User>(
            future: currentUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                nearbyFarmers = farmers
                    .where((farmer) =>
                        farmer.address["parish"] ==
                        snapshot.data!.address["parish"])
                    .toList();
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      centerTitle: true,
                      title: SizedBox(
                          width: Dimensions.width70,
                          child: Image.asset(
                            'assets/icons/logo.png',
                            fit: BoxFit.cover,
                          )),
                      foregroundColor: Colors.black,
                      pinned: true,
                      floating: true,
                      titleSpacing: Dimensions.width15,
                      toolbarHeight: Dimensions.height70,
                      collapsedHeight: 75,

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
                                    right: Dimensions.width15,
                                  ),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white54,
                                      radius: Dimensions.radius30,
                                      backgroundImage: setProfileImage(
                                          snapshot.data!.image)),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: Dimensions.height20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width15),
                              child: SizedBox(
                                height: 45,
                                child: TextField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.width20),
                                      focusColor: Colors.white,
                                      focusedBorder: OutlineInputBorder(

                                          // borderSide: BorderSide(color: Colors.transparent),
                                          ),
                                      border: OutlineInputBorder(
                                        // borderSide:
                                        // BorderSide(width: 0, style: BorderStyle.none),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius5),
                                      ),
                                      prefixIcon: Icon(Icons.search),
                                      hintText: 'Search ',
                                      fillColor: Colors.white,
                                      filled: true),
                                  readOnly: true,
                                  onTap: () {
                                    showSearch(
                                        context: context,
                                        delegate: CustomSearchDelegate(
                                            searchTerms: produce));
                                  },
                                ),
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width10,
                                vertical: Dimensions.height20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                LargeText(
                                  text: 'Categories',
                                  size: Dimensions.height20,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.height15),
                            color: AppColors.mainGreen.withOpacity(0.3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: categories.map(
                                (Category c) {
                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: Image.network(
                                            c.category_img,
                                            fit: BoxFit.contain,
                                          )),
                                      LargeText(
                                        text: c.category_name.toUpperCase(),
                                        color: Colors.black87,
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width10,
                                    vertical: Dimensions.height20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LargeText(
                                      text: 'In Season',
                                      size: Dimensions.height20,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.inSeasonContPri,
                                child: PageView.builder(
                                  padEnds: false,
                                  controller: pageController,
                                  itemCount: (products.length >= 3)
                                      ? 3
                                      : products.length,
                                  itemBuilder:
                                      (BuildContext context, position) {
                                    return _buildPageItem(
                                        position, products[position]);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              DotsIndicator(
                                dotsCount: 3,
                                position: _currPageValue,
                                decorator: DotsDecorator(
                                    color: Colors.black12, // Inactive
                                    size: Size.square(Dimensions.height10),
                                    activeColor: AppColors.mainGreen),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LargeText(
                                      text: 'Nearby Farmers',
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(left: Dimensions.width10),
                                height: 200,
                                width: double.maxFinite,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (nearbyFarmers.length >= 5)
                                        ? 5
                                        : nearbyFarmers.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return FarmerDetails(
                                                    farmer:
                                                        nearbyFarmers[index]);
                                              },
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: Dimensions.width10,
                                              top: Dimensions.height10),
                                          width: 130,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius5),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    nearbyFarmers[index].image),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                    child:
                        CircularProgressIndicator(color: AppColors.mainGreen));
              }
            }));
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
  ];
//pageview slider
  Widget _buildPageItem(int index, Product product) {
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
            height: Dimensions.inSeasonContSec,
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, Dimensions.height5),
                    blurRadius: Dimensions.radius5,
                    color: Color(0xFFF4F4F4),
                  ),
                ],
                borderRadius: BorderRadius.circular(
                  Dimensions.radius5,
                ),
                color: Colors.white),
            child: Row(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                height: double.maxFinite,
                child: Image(
                  image: setProduceImage(product.prod_img),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10,
                      vertical: Dimensions.height10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LargeText(
                        text: '${product.prod_name}',
                        size: Dimensions.height20,
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      LargeText(
                        text: "Regions",
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      GridView.builder(
                        itemCount: locations.length,
                        itemBuilder: (context, index) => SizedBox(
                          height: Dimensions.height5,
                          child: SmallText(
                            text: locations[index],
                          ),
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 0,
                            mainAxisExtent: 24,
                            crossAxisCount: 2,
                            childAspectRatio: 3,
                            crossAxisSpacing: Dimensions.width10),
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
                                return ProduceDetails(product: product);
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
  List<String> searchTerms;
  CustomSearchDelegate({required this.searchTerms});

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
    for (var x in this.searchTerms) {
      if (x.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(x);
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
    for (var x in this.searchTerms) {
      if (x.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(x);
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
