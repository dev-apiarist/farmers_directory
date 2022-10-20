import 'package:flutter/material.dart';

import '../../../widgets/lg_text.dart';
import '../../../widgets/sm_text.dart';
import '../details/farmer_details.dart';

class FarmersList extends StatelessWidget {
  const FarmersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return FarmerDetails();
          }));
        },
        isThreeLine: true,
        horizontalTitleGap: 5,
        visualDensity: VisualDensity(vertical: 4),
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        leading: CircleAvatar(
          backgroundColor: Colors.white70,
          radius: 45,
          backgroundImage: NetworkImage(
              'https://www.caribbeannationalweekly.com/wp-content/uploads/2017/07/JULY-27-Farming-JAMICA-YOUTH-VOLUNTEER-PROGRAM.jpg'),
        ),
        title: LargeText(text: 'Devin Di Dakta'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallText(size: 15, text: 'Main Produce:'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LargeText(
              text: 'Connect',
              size: 17,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
