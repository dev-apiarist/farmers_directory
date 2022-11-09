import 'package:farmers_directory/widgets/category_buttons.dart';
import 'package:farmers_directory/widgets/produce.dart';
import 'package:flutter/material.dart';

import '../../../widgets/lg_text.dart';
import "package:farmers_directory/resources/produce.dart";

class FarmerProduceList extends StatefulWidget {
  FarmerProduceList(List<Map<String, String>> this.produce, {super.key});
  List<Map<String, String>> produce = [];

  @override
  State<FarmerProduceList> createState() => _FarmerProduceListState();
}

class _FarmerProduceListState extends State<FarmerProduceList> {
  late List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(Produce.item.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider();
      },
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: Produce.item.length,
      itemBuilder: (context, index) {
        return Dismissible(
          behavior: HitTestBehavior.deferToChild,
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          background: Container(
              alignment: AlignmentDirectional.centerEnd,
              child: Icon(Icons.delete)),
          confirmDismiss: (direction) async {
            return await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: LargeText(
                      text: "Are you sure you want to remove this produce?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Remove'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          },
          child: CheckboxListTile(
            title: LargeText(text: Produce.item[index]["name"].toString()),
            controlAffinity: ListTileControlAffinity.leading,
            value: _isChecked[index],
            onChanged: (value) {
              setState(() {
                _isChecked[index] = value!;
              });
            },
          ),
        );
      },
    );
  }
}
