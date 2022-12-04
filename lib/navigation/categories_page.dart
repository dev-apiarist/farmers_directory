import 'dart:convert';
import 'package:farmers_directory/pages/users/lists/produce_list.dart';
import 'package:farmers_directory/utils/functions.dart';
import 'package:farmers_directory/widgets/leading_icon.dart';
import 'package:flutter/material.dart';
import '../models/category.model.dart';
import '../models/product.model.dart';
import '../services/network_handler_service.dart';
import '../utils/utils.dart';
import '../widgets/typography.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
  TabController? tabController;

  late Future<List<Category>> allCategories;
  int categoryLength = 0;
  List<Product> products = [];

  getProducts() async {
    Map<String, dynamic> response =
        jsonDecode(await NetworkHandler.get(endpoint: "/products"));
    List productsList = response["data"];
    setState(() {
      products = productsList.map((product) {
        return Product.fromJson(product);
      }).toList();
    });
  }

  Future<List<Category>> getCategories() async {
    Map<String, dynamic> response =
        jsonDecode(await NetworkHandler.get(endpoint: "/categories"));
    List categoryList = response["data"];
    List<Category> categories = categoryList.map((category) {
      return Category.fromJson(category);
    }).toList();
    return categories;
  }

  @override
  void initState() {
    super.initState();
    getProducts();
    allCategories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const LargeText(
          text: 'Categories',
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
        elevation: 0,
        backgroundColor: AppColors.mainGreen,
      ),
      body: FutureBuilder<List<Category>>(
        future: allCategories,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            tabController =
                TabController(length: snapshot.data!.length, vsync: this);

            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: Dimensions.height10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      // indicator: CircleTabIndicator(color: Colors.black, radius: 4),
                      indicatorColor: Colors.lightGreen,
                      isScrollable: true,
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      controller: tabController,
                      tabs: snapshot.data!.map((category) {
                        return Tab(text: category.category_name);
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: snapshot.data!.map((category) {
                          List<Product> filteredProduct =
                              products.where((product) {
                            return product.category == category.id;
                          }).toList();
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...showInSeasonWhen(category.category_name,
                                    "Livestock", filteredProduct),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: (() =>
                                          GlobalFunctions.botomSheet(context)),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          LeadingIconText(
                                            text: 'Sort By',
                                            icon: Icons.sort,
                                            iconSize: Dimensions.height20,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Expanded(
                                    child: ProduceList(
                                  productList: filteredProduct,
                                )),
                              ],
                            ),
                          );
                        }).toList()),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// class CircleTabIndicator extends Decoration {
//   final Color color;
//   final double radius;
//   const CircleTabIndicator({required this.color, required this.radius});

//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
//     return _CirclePainter(color: color, radius: radius);
//   }
// }

// class _CirclePainter extends BoxPainter {
//   final Color color;
//   double radius;
//   _CirclePainter({required this.color, required this.radius});

//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
//     Paint paint = Paint();
//     paint.color = color;
//     paint.isAntiAlias = true;
//     final Offset circleOffset = Offset(
//         configuration.size!.width / 2 - radius / 2, configuration.size!.height);
//     canvas.drawCircle(offset + circleOffset, radius, paint);
//   }
// }

columnFunction() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.height10, horizontal: Dimensions.width20),
        child: LargeText(text: 'Livestock Breeding'),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
        height: 250,
        width: double.maxFinite,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 0,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.only(
                      right: Dimensions.width15, top: Dimensions.height10),
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "",
                      ),
                    ),
                  ));
            }),
      ),
      const SizedBox(height: 30),
    ],
  );
}

List<Widget> showInSeasonWhen(constant, variable, List<Product> products) {
  var seasonProduce =
      products.where((element) => element.inSeason == true).toList();
  if (constant == variable) {
    return [const SizedBox.shrink()];
  } else {
    return [
      LargeText(text: 'In Season'),
      Container(
        height: 200,
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: seasonProduce.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                  right: Dimensions.width15, top: Dimensions.height10),
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius5),
                image: DecorationImage(
                    image: NetworkImage(seasonProduce[index].prod_img),
                    fit: BoxFit.cover),
              ),
            );
          },
        ),
      ),
      SizedBox(height: 30),
    ];
  }
}
