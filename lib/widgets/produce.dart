import 'package:farmers_directory/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'sm_text.dart';

class FarmerProduce extends StatelessWidget {
  const FarmerProduce({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: Dimensions.height10,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.9 / .3,
          crossAxisCount: 4,
          children: produce.map((String value) {
            return Row(
              children: [
                Icon(
                  Icons.fiber_manual_record,
                  size: 8,
                ),
                SizedBox(
                  width: Dimensions.width2,
                ),
                SmallText(text: value),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

List<String> produce = [
  'Weed',
  'Tomato',
  'Pumpkin',
  'Onion',
  'Yam',
];
