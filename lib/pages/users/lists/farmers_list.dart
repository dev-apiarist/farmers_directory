import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/widgets/leading_icon.dart';
import 'package:flutter/material.dart';

import '../../../widgets/lg_text.dart';
import '../../../widgets/sm_text.dart';
import '../details/farmer_details.dart';

class FarmersList extends StatelessWidget {
  const FarmersList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return FarmerDetails();
        }));
      },
      isThreeLine: true,
      horizontalTitleGap: Dimensions.width10,
      visualDensity: VisualDensity(vertical: 4),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Dimensions.width20,
        vertical: Dimensions.height5,
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 40,
        backgroundImage: AssetImage('assets/images/user_profile.jpeg'),
      ),
      title: SmallText(
        text: 'Debra Passie',
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LargeText(
            text: 'Main Produce:',
            size: 16,
          ),
          SizedBox(
            height: Dimensions.height5,
          ),
          Wrap(
            spacing: Dimensions.width10,
            children: List.generate(5, (index) {
              return LeadingIconText(
                icon: Icons.fiber_manual_record,
                text: 'Yam',
                color: Colors.black87,
                iconSize: Dimensions.height10,
                textSize: Dimensions.font14,
              );
            }),
          ),
        ],
      ),
    );
  }
}
