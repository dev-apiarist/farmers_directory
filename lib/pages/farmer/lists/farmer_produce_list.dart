import 'package:flutter/material.dart';

import '../../../widgets/lg_text.dart';

class FarmerProduceList extends StatefulWidget {
  const FarmerProduceList({super.key});

  @override
  State<FarmerProduceList> createState() => _FarmerProduceListState();
}

class _FarmerProduceListState extends State<FarmerProduceList> {
  List<String> _produce = ["Apples", "Banana", "Yam"];

  late List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(_produce.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider();
      },
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _produce.length,
      itemBuilder: (context, index) {
        return Dismissible(
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
                  title: LargeText(text: _produce[index]),
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
            controlAffinity: ListTileControlAffinity.leading,
            value: _isChecked[index],
            onChanged: (value) {
              setState() {
                _isChecked[index] = !value!;
              }
            },
            title: LargeText(text: _produce[index]),
          ),
        );
      },
    );
  }
}
