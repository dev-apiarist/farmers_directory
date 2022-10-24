import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LargeText(
      text: "Coming Soon!",
      size: 50,
    ));
  }
}
