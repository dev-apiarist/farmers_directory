import 'package:farmers_directory/utils/colors.dart';
import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/widgets/app_icon.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';

class FeaturedProduceDetails extends StatelessWidget {
  const FeaturedProduceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            elevation: 0,
            pinned: true,
            backgroundColor: AppColors.mainGreen,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/apple.png',
                width: double.maxFinite,
                fit: BoxFit.contain,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Container(
                height: 40,
                width: double.maxFinite,
                child: Center(
                    child: LargeText(
                        size: 17, text: '11 Farmers are selling apples')),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Expanded(
              child: ListView.separated(
                separatorBuilder: ((context, index) => Divider()),
                padding: EdgeInsets.only(top: Dimensions.height10),
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                              'https://www.fao.org/fileadmin/templates/medium/images/cover/medium_f4e954508cf99ed40685cb068a8eb814.JPG'),
                        ),
                        SizedBox(
                          width: Dimensions.width20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LargeText(text: 'Ivan Dunkley'),
                              SmallText(text: 'Kingston')
                            ],
                          ),
                        ),
                        LargeText(
                          size: 16,
                          text: 'Connect',
                          color: Colors.green,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
