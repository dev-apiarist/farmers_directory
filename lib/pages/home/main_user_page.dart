import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:farmers_directory/models/category.model.dart';
import 'package:farmers_directory/navigation/categories_page.dart';
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
  late Future <User> currentUser;
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.95;
  List<Category> categories = [];
  List<Farmer> farmers = [];
  List<Product> products = [];
  List<Farmer> nearbyFarmers = [];


  getFarmers() async{
    Map<String, dynamic> response = jsonDecode(await NetworkHandler.get(endpoint:"/farmers"));
    List farmersList = response["data"];
    setState((){
      farmers = farmersList.map((farmer){
        return Farmer.fromJson(farmer);
      }).toList();
    });
  }
  getProducts() async{
    Map<String, dynamic> response = jsonDecode(await NetworkHandler.get(endpoint:"/products"));
    List productsList = response["data"];
    setState((){
      products = productsList.map((product){
        return Product.fromJson(product);
      }).toList();
    });
  }
  getCategories() async{
    Map<String, dynamic> response = jsonDecode(await NetworkHandler.get(endpoint:"/categories"));
    List categoryList = response["data"];
    setState((){
      categories = categoryList.map((category){
        return Category.fromJson(category);
      }).toList();
    });
  }
  getData() async{
      try{
         getFarmers();
         getCategories();
         getProducts();
      }catch(error){
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

      // drawer: Drawer(),
      body: FutureBuilder<User>(
        future:currentUser,
        builder: (context,snapshot) {
          if(snapshot.hasData){
            nearbyFarmers = farmers.where((farmer) => farmer.address["parish"] == snapshot.data!.address["parish"]).toList();
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 10,

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
                          delegate:
                              CustomSearchDelegate(searchTerms: locations),
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
                      (Map<String, String> e) {
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
                                  e['categoryImg']!,
                                  fit: BoxFit.cover,

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

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: PageView.builder(
                        padEnds: false,
                        controller: pageController,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, position) {
                          return _buildPageItem(position);
                        },

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
                          backgroundImage: setProfileImage(snapshot.data!.image)
                    ),
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
                                (Category c) {
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

                                        child:Image.network(c.category_img),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SmallText(
                                    text: c.category_name,
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
                              itemCount: (products.length >= 3)? 3 : products.length,
                              itemBuilder: (BuildContext context, position) {
                                return _buildPageItem(position, products[position]);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
                          Container(
                              padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10),
                              height: 200,
                              width: double.maxFinite,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: (nearbyFarmers.length >= 5)? 5 : nearbyFarmers.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return FarmerDetails(
                                                farmer: nearbyFarmers[index]);
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: Dimensions.width15,
                                          top: Dimensions.height10),
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(
                                            Dimensions.height20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                nearbyFarmers[index].image),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  );
                                }
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          }else{
            return Center(child:CircularProgressIndicator());
          }
        }
      )
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
  Widget _buildPageItem( int index, Product product) {

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
                width: MediaQuery.of(context).size.width * 0.3,
                height: double.maxFinite,
                child: Image(image: setProduceImage(product.prod_img)),
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
                        text: '${product.prod_name}',
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
