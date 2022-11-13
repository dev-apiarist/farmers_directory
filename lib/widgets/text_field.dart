import 'package:farmers_directory/widgets/lg_text.dart';
import 'package:farmers_directory/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  bool isPassword;
  TextEditingController? controller;
  String title;
  String placeholder;
  bool isNumber;
  CustomTextField(
      {super.key,
      this.isPassword = false,
      this.isNumber = false,
      this.placeholder = '',
        this.controller = null,
      required this.title,
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmallText(text: widget.title),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              controller: widget.controller,
              scrollPhysics: BouncingScrollPhysics(),
              keyboardType:
                  widget.isNumber ? TextInputType.number : TextInputType.text,
              obscureText: widget.isPassword,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.4))),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: widget.placeholder,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  filled: true,
                  fillColor: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
