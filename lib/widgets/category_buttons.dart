import 'package:farmers_directory/utils/colors.dart';
import 'package:flutter/material.dart';

const List<Widget> category = <Widget>[
  Text('Crops'),
  Text('Livestock'),
];

class CategoryToggle extends StatefulWidget {
  const CategoryToggle({super.key});

  @override
  State<CategoryToggle> createState() => _CategoryToggleState();
}

class _CategoryToggleState extends State<CategoryToggle> {
  final List<bool> _selectedCategory = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < _selectedCategory.length; i++) {
            _selectedCategory[i] = i == index;
          }
        });
      },
      selectedBorderColor: AppColors.mainGreen,
      selectedColor: Colors.white,
      fillColor: AppColors.mainGreen,
      color: AppColors.mainGreen,
      constraints: const BoxConstraints(
        minHeight: 40.0,
        minWidth: 80.0,
      ),
      isSelected: _selectedCategory,
      children: category,
    );
  }
}
