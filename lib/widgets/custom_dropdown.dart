// import 'package:flutter/material.dart';

// import 'sm_text.dart';

// class CustomDropdown extends StatefulWidget {
//   const CustomDropdown({super.key, required this.text});
//   final String text;
//   @override
//   State<CustomDropdown> createState() => _CustomDropdownState();
// }

// class _CustomDropdownState extends State<CustomDropdown> {
//   late GlobalKey actionKey;
//   double? height;
//   double? width;
//   double? xPosition;
//   double? yPosition;
//   bool isDropdownOpen = false;
//   OverlayEntry? floatingDropdown;
//   @override
//   void initState() {
//     actionKey = LabeledGlobalKey(widget.text);
//     super.initState();
//   }

//   void findDropdownData() {
//     RenderBox renderBox =
//         actionKey.currentContext!.findRenderObject()! as RenderBox;
//     height = renderBox.size.height;
//     width = renderBox.size.width;
//     Offset offset = renderBox.localToGlobal(Offset.zero);
//     xPosition = offset.dx;
//     yPosition = offset.dy;

//     print(height);
//     print(width);
//     print(xPosition);
//     print(yPosition);
//   }

//   OverlayEntry _createFloatingDropdown() {
//     return OverlayEntry(builder: (context) {
//       return Positioned(
//         left: xPosition,
//         width: width,
//         top: yPosition! + height!,
//         height: 4 * height! + 40,
//         child: Container(child: Text('jfd')),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       key: actionKey,
//       onTap: () {
//         ;
//         setState(() {
//           if (isDropdownOpen) {
//             floatingDropdown!.remove();
//           } else {
//             findDropdownData();
//             floatingDropdown = _createFloatingDropdown();
//             Overlay.of(context)!.insert(floatingDropdown!);
//           }
//           isDropdownOpen = !isDropdownOpen;
//         });
//       },
//       child: Container(
//         child: Row(
//           children: [
//             Text(widget.text),
//             Icon(Icons.arrow_drop_down),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DropDown extends StatelessWidget {
//   const DropDown({super.key, required this.itemHeight});
//   final double itemHeight;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             DropDownItem(
//               text: 'Kingston',
//               isSelected: true,
//             )
//           ]),
//         ),
//       ],
//     );
//   }
// }

// class DropDownItem extends StatelessWidget {
//   const DropDownItem({super.key, required this.isSelected, required this.text});
//   final String text;
//   final bool isSelected;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.red,
//       child: SmallText(text: text),
//     );
//   }
// }

