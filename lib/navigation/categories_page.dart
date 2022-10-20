import 'package:farmers_directory/pages/users/details/farmer_details.dart';
import 'package:farmers_directory/pages/users/details/produce_details.dart';
import 'package:farmers_directory/pages/users/lists/farmers_list.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:flutter/material.dart';

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
    final List<String> imageUrls = [
      'https://ychef.files.bbci.co.uk/976x549/p099bkjt.jpg',
      'https://cdn.shopify.com/s/files/1/0431/5214/6584/products/image_c4b44c20-2e5c-47db-8b20-922942e50e42_1024x1024@2x.jpg?v=1623782661',
      'https://upload.wikimedia.org/wikipedia/commons/4/46/Litchi_chinensis_fruits.JPG'
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: LargeText(text: 'Categories'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                indicator: CircleTabIndicator(color: Colors.black, radius: 4),
                isScrollable: true,
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                controller: tabController,
                tabs: [
                  Tab(
                    text: 'Crops',
                  ),
                  Tab(
                    text: 'Farmers',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: LargeText(text: ' In Season'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return ProduceDetails();
                          }));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 250,
                          width: double.maxFinite,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: imageUrls.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 15, top: 10),
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(imageUrls[index]),
                                        fit: BoxFit.cover),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(''),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(''),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(''),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              _filter(context);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LargeText(text: 'Filter'),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.sort,
                                  color: Colors.black87,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: ((context, index) => Divider()),
                          padding: EdgeInsets.only(top: Dimensions.height10),
                          itemCount: 10,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return FarmersList();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
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

void _filter(context) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      )),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    LargeText(
                      align: TextAlign.center,
                      text: 'Filters',
                      size: 25,
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close),
                      ),
                    )
                  ],
                ),
              ],
            )
          ]),
        );
      });
}
