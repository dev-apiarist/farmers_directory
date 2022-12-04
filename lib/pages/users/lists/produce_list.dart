import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:flutter/material.dart';
import '../../../models/product.model.dart';
import '../details/produce_details.dart';

class ProduceList extends StatelessWidget {
  const ProduceList({super.key, required this.productList});

  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: ((context, index) {
        return const Divider();
      }),
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: productList.length,
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: (() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ProduceDetails(product: productList[index]);
                },
              ),
            );
          }),
          child: ListTile(
            title: LargeText(text: productList[index].prod_name),
          ),
        );
      }),
    );
  }
}
