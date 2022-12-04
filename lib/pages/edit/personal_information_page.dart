import 'package:flutter/material.dart';

import '../../widgets/typography.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LargeText(text: 'Personal Information'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.done,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(
              height: 20,
            ),
            LargeText(text: 'Address'),
            TextField(
              decoration: InputDecoration(labelText: 'Street Address'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'City'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Parish'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
