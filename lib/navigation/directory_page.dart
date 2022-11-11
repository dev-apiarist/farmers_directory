import 'package:farmers_directory/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../pages/users/lists/farmers_list.dart';
import '../utils/dimensions.dart';
import '../widgets/lg_text.dart';

class Directory extends StatelessWidget {
  const Directory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: LargeText(
          text: 'Farmers',
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  GlobalFunctions.botomSheet(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LargeText(text: 'Filter'),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.sort,
                      color: Colors.black87,
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: ((context, index) => Divider()),
              padding: EdgeInsets.only(top: Dimensions.height10),
              itemCount: 5,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return FarmersList();
              },
            ),
          ),
        ],
      ),
    );
  }
}
