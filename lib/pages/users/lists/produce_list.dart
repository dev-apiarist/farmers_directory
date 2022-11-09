import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../models/category.model.dart';
import '../../../models/product.model.dart';

class ProduceList extends StatelessWidget {
  ProduceList({super.key ,this.category="", required this.productList});

  final String category;
  final List<Product> productList;
  late List<Product> filteredProduct;


  @override
  initState(){
    filteredProduct = productList.where((product){
      return product.category == category;
    }).toList();
  }
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
