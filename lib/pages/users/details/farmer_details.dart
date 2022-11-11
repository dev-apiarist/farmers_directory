import 'package:farmers_directory/pages/users/details/produce_details.dart';
import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/leading_icon.dart';
import 'package:farmers_directory/widgets/sm_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmerDetails extends StatelessWidget {
  const FarmerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    String contactNumber = '+1 876 286-8246';
    String email = 'johnbrown24@gmail.com';

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate:
                CustomSliverAppBar(expandedHeight: Dimensions.expandedHeight),
            pinned: true,
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: LargeText(
                      text: 'Debra Passie',
                      size: 30,
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
                            text: 'Organic Cultivator',
                            icon: Icons.work_outline,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          LeadingIconText(
                            iconSize: Dimensions.height20,
                            text: "Kingston",
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
                          spacing: 5,
                          children: List.generate(5, (index) {
                            return GestureDetector(
                              onTap: (() {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ProduceDetails();
                                    },
                                  ),
                                );
                              }),
                              child: Chip(
                                backgroundColor: Colors.white,
                                side: BorderSide(color: Colors.black54),
                                label: SmallText(
                                  text: 'Potato',
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
                    size: 17,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SmallText(
                    text:
                        'Expert cultivator. Ensuring we Grow, smart. Eat smart. Supplying a better Jamaica.',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (() async {
                      String url = 'tel:$contactNumber';
                      final parseUrl = Uri.parse(url);
                      if (await canLaunchUrl(parseUrl)) {
                        await launchUrl(
                          parseUrl,
                        );
                      }
                    }),
                    child: LeadingIconText(
                      text: contactNumber,
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
                          'mailto:$email?subject=$subject=$subject&body=$body';
                      final parseUrl = Uri.parse(emailUrl);
                      if (await canLaunchUrl(parseUrl)) {
                        await launchUrl(
                          parseUrl,
                        );
                      }
                    }),
                    child: LeadingIconText(
                      text: email,
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
  CustomSliverAppBar({required this.expandedHeight});
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
                  top: Radius.circular(40),
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
                  backgroundImage:
                      AssetImage('assets/images/user_profile.jpeg'),
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

