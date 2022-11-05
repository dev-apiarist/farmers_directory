import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProduceList extends StatelessWidget {
  const ProduceList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: ((context, index) {
        return Divider();
      }),
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: ((context, index) {
        return ListTile(
          title: LargeText(text: 'Apples'),
        );
      }),
    );
  }
}
