import 'package:farmers_directory/pages/farmer/lists/farmer_produce_list.dart';
import 'package:farmers_directory/pages/users/lists/produce_list.dart';
import 'package:farmers_directory/resources/produce.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/utils/functions.dart';
import 'package:farmers_directory/widgets/category_buttons.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';
import "package:farmers_directory/resources/produce.dart";

import '../../resources/produce.dart';

class MainFarmerPage extends StatefulWidget {
  const MainFarmerPage({super.key});

  @override
  State<MainFarmerPage> createState() => _MainFarmerPageState();
}

class _MainFarmerPageState extends State<MainFarmerPage> {
  final controller = TextEditingController();

  List<Map<String, String>> foundProduce = [];

  @override
  void initState() {
    foundProduce = Produce.item;
    super.initState();
  }

  void _runFilter(String query) {
    List<Map<String, String>> results = [];

    if (query.isEmpty) {
      results = Produce.item;
    } else {
      results = Produce.item
          .where(
            (name) => name["name"]!.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }
    setState(() {
      foundProduce = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.mainGreen,
            title: LargeText(
              text: 'Update Produce',
              color: Colors.white,
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CategoryToggle(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: controller,
                              onChanged: (value) => _runFilter(value),
                              decoration: InputDecoration(labelText: 'Search'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              GlobalFunctions.botomSheet(context);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.sort),
                                SizedBox(
                                  width: 10,
                                ),
                                SmallText(text: 'Sort by')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FarmerProduceList(foundProduce)
              ],
            ),
          )
        ],
      ),
    );
  }
}
