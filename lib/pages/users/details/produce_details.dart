import 'package:farmers_directory/pages/users/lists/farmers_list.dart';
import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/widgets/app_icon.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';

import 'farmer_details.dart';

class ProduceDetails extends StatelessWidget {
  const ProduceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.mainGreen,
            floating: true,
            elevation: 0,
            pinned: true,
            expandedHeight: Dimensions.expandedHeight,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned(
                    top: 100,
                    left: 80,
                    child: CircleAvatar(
                      radius: 200,
                      backgroundColor: Colors.black26,
                    ),
                  ),
                  Positioned(
                      left: 80,
                      top: 30,
                      child: SizedBox(
                        width: 300,
                        height: 250,
                        child: Image.asset(
                          'assets/images/mango.png',
                          fit: BoxFit.cover,
                        ),
                      ))
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height40),
              child: Container(
                height: Dimensions.height40,
                width: double.maxFinite,
                child: Center(
                  child: SmallText(
                    text: '11 Farmers are selling apples',
                    size: Dimensions.height20,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Expanded(
              child: Column(
                children: [
                  ListView.separated(
                    separatorBuilder: ((context, index) => Divider()),
                    padding: EdgeInsets.only(top: Dimensions.height10),
                    itemCount: 11,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return FarmersList();
                    },
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
