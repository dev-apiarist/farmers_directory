import 'package:farmers_directory/pages/users/details/produce_details.dart';
import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/utils/functions.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/leading_icon.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/farmer.model.dart';

class FarmerDetails extends StatelessWidget {
  const FarmerDetails({super.key, required this.farmer});

  final Farmer farmer;
  @override
  Widget build(BuildContext context) {
    String contactNumber = farmer.phone;
    String email = farmer.email;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomSliverAppBar(
                expandedHeight: Dimensions.expandedHeight,
                profile_img: farmer.image),
            pinned: true,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height40),
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: LargeText(
                      text: '${farmer.fname} ${farmer.lname}',
                      size: Dimensions.font30,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          LeadingIconText(
                            iconSize: Dimensions.height20,
                            text: '${farmer.farmer_type}',
                            icon: Icons.work_outline,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          LeadingIconText(
                            iconSize: Dimensions.height20,
                            text: "${farmer.address["parish"]}",
                            icon: Icons.location_on_outlined,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Dimensions.height10),
                        child: LargeText(
                          text: 'Produce:',
                        ),
                      ),
                      SizedBox(width: Dimensions.width10),
                      Expanded(
                        child: Wrap(
                          spacing: Dimensions.width5,
                          children:
                              List.generate(farmer.products.length, (index) {
                            return GestureDetector(
                              onTap: (() {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProduceDetails(
                                          product: farmer.products[index]);
                                    },
                                  ),
                                );
                              }),
                              child: Chip(
                                backgroundColor: Colors.white,
                                side: BorderSide(color: Colors.black54),
                                label: SmallText(
                                  size: 13,
                                  text: '${farmer.products[index].prod_name}',
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  LargeText(
                    text: 'About',
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SmallText(
                    text: '${farmer.description}',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (() async {
                      String url = 'tel:${farmer.phone}';
                      final parseUrl = Uri.parse(url);
                      if (await canLaunchUrl(parseUrl)) {
                        await launchUrl(
                          parseUrl,
                        );
                      }
                    }),
                    child: LeadingIconText(
                      text: farmer.phone,
                      icon: Icons.call_outlined,
                      iconSize: Dimensions.height20,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (() async {
                      String subject = '';
                      String body = '';
                      String emailUrl =
                          'mailto:${farmer.email}?subject=$subject=$subject&body=$body';
                      final parseUrl = Uri.parse(emailUrl);
                      if (await canLaunchUrl(parseUrl)) {
                        await launchUrl(
                          parseUrl,
                        );
                      }
                    }),
                    child: LeadingIconText(
                      text: farmer.email,
                      color: Colors.black87,
                      icon: Icons.email_outlined,
                      iconSize: Dimensions.height20,
                    ),
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

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String profile_img;
  CustomSliverAppBar({required this.expandedHeight, required this.profile_img});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (() {
            Navigator.of(context).pop();
          }),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            'assets/images/fields.jpeg',
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Dimensions.height40),
                ),
                child: Container(
                  height: 40,
                  color: Colors.white,
                  width: double.maxFinite,
                ),
              ),
            ),
          ),
          Positioned(
            top: expandedHeight / 1.55 - shrinkOffset,
            left: MediaQuery.of(context).size.width / 4,
            right: MediaQuery.of(context).size.width / 4,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 75,
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: setProfileImage(profile_img),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
