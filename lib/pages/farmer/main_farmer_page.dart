import 'package:farmers_directory/pages/farmer/lists/farmer_produce_list.dart';
import 'package:farmers_directory/pages/users/lists/produce_list.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';

class MainFarmerPage extends StatefulWidget {
  const MainFarmerPage({super.key});

  @override
  State<MainFarmerPage> createState() => _MainFarmerPageState();
}

class _MainFarmerPageState extends State<MainFarmerPage> {
  String searchString = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(300),
            //     bottomRight: Radius.circular(500),
            //   ),
            // ),
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: RichText(
                text: TextSpan(
                    text: 'Welcome,',
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(text: '\nJohn', style: TextStyle(fontSize: 20))
                    ]),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      LargeText(text: 'Select Produce'),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: SmallText(
                              text: 'Crops',
                              color: Colors.white,
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.mainGreen,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: SmallText(
                              text: 'Livestock',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                            child: TextField(
                              onChanged: (value) {
                                setState(
                                  () {
                                    searchString = value.toLowerCase();
                                  },
                                );
                              },
                              decoration: InputDecoration(labelText: 'Search'),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.sort),
                              ),
                              SmallText(text: 'Sort by')
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FarmerProduceList()
              ],
            ),
          )
        ],
      ),
    );
  }
}
