import 'package:farmers_directory/widgets/typography.dart';
import 'package:flutter/material.dart';

class EditPassword extends StatelessWidget {
  const EditPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LargeText(text: 'Password'),
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
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'New Password'),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Confirm Password'),
            ),
          ],
        ),
      ),
    );
  }
}
