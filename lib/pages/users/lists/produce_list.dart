import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../models/category.model.dart';
import '../../../models/product.model.dart';

class ProduceList extends StatelessWidget {
  ProduceList({super.key ,required this.productList});

  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: ((context, index) {
        return Divider();
      }),
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: productList.length,
      itemBuilder: ((context, index) {
        return ListTile(
          title: LargeText(text: productList[index].prod_name),
        );
      }),
    );
  }
}
