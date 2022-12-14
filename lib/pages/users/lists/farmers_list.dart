import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/utils/functions.dart';
import 'package:farmers_directory/widgets/leading_icon.dart';
import 'package:flutter/material.dart';

import '../../../models/farmer.model.dart';
import '../../../widgets/lg_text.dart';
import '../../../widgets/sm_text.dart';
import '../details/farmer_details.dart';

class FarmersList extends StatelessWidget {
  const FarmersList({super.key, required this.farmer});

  final Farmer farmer;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return FarmerDetails(farmer: farmer);
        }));
      },
      isThreeLine: true,
      horizontalTitleGap: Dimensions.width10,
      visualDensity: const VisualDensity(vertical: 4),
      contentPadding: EdgeInsets.symmetric(
        horizontal: Dimensions.width20,
        vertical: Dimensions.height5,
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.white70,
        radius: 40,
        backgroundImage: setProfileImage(farmer.image),
      ),
      title: SmallText(
        text: '${farmer.first_name} ${farmer.last_name}',
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LargeText(
            text: 'Main Produce:',
          ),
          SizedBox(
            height: Dimensions.height5,
          ),
          Wrap(
            spacing: Dimensions.width10,
            children: List.generate(farmer.products.length, (index) {
              return LeadingIconText(
                icon: Icons.fiber_manual_record,
                text: farmer.products[index].prod_name,
                color: Colors.black87,
                iconSize: Dimensions.height10,
                textSize: Dimensions.sm,
              );
            }),
          ),
        ],
      ),
    );
  }
}
