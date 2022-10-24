import 'package:farmers_directory/pages/users/details/farmer_details.dart';
import 'package:farmers_directory/pages/users/details/produce_details.dart';
import 'package:farmers_directory/pages/users/lists/farmers_list.dart';
import 'package:farmers_directory/pages/users/lists/produce_list.dart';
import 'package:farmers_directory/utils/functions.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../widgets/sm_text.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> inSeasonImages = [
      'https://ychef.files.bbci.co.uk/976x549/p099bkjt.jpg',
      'https://cdn.shopify.com/s/files/1/0431/5214/6584/products/image_c4b44c20-2e5c-47db-8b20-922942e50e42_1024x1024@2x.jpg?v=1623782661',
      'https://upload.wikimedia.org/wikipedia/commons/4/46/Litchi_chinensis_fruits.JPG'
    ];

    final List<String> livestockImages = [
      'https://www.jddb.gov.jm/sites/default/files/styles/max_1300x1300/public/inline-images/Jamaica%20Hope%20Calves_0.JPG?itok=wDQaxLcx',
      'https://loopnewslive.blob.core.windows.net/liveimage/sites/default/files/2018-04/ggwsIv7oNp.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnUcoHJKf0M1qxbU6VIZcSdYrST4lz2Q-YolEwqO6lIHuqxJq6DKLw6fufDyl-TfE3jKc&usqp=CAU'
    ];
    return Scaffold(
      appBar: AppBar(
        title: LargeText(
          text: 'Categories',
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
        elevation: 0,
        backgroundColor: AppColors.mainGreen,
      ),
      body: Column(
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
                tabs: [
                  Tab(
                    text: 'Crops',
                  ),
                  Tab(
                    text: 'Livestock',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LargeText(text: 'In Season'),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProduceDetails();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: 200,
                              width: double.maxFinite,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: inSeasonImages.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        right: Dimensions.width15,
                                        top: Dimensions.height10),
                                    width: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              inSeasonImages[index]),
                                          fit: BoxFit.cover),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: AppColors.mainGreen),
                                    onPressed: () {},
                                    child: LargeText(
                                      text: 'Fruits',
                                      color: Colors.white,
                                    ),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: LargeText(
                                        text: 'Vegetables',
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: (() =>
                                    GlobalFunctions.botomSheet(context)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.sort),
                                    SmallText(text: 'Sort By')
                                  ],
                                ),
                              )
                            ],
                          ),
                          Expanded(child: ProduceList()),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: LargeText(text: 'Livestock Breeding'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProduceDetails();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 250,
                          width: double.maxFinite,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: livestockImages.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 15, top: 10),
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            livestockImages[index]),
                                        fit: BoxFit.cover),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2, configuration.size!.height);
    canvas.drawCircle(offset + circleOffset, radius, paint);
  }
}
