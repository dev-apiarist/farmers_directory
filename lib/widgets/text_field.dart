import 'package:farmers_directory/utils/dimensions.dart';
import 'package:farmers_directory/widgets/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final bool isEmail;
  final bool isPassword;
  final TextEditingController? controller;
  final String title;
  final String placeholder;
  final bool isNumber;
  const CustomTextField({
    super.key,
    this.isPassword = false,
    this.isEmail = false,
    this.isNumber = false,
    this.placeholder = '',
    this.controller,
    required this.title,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmallText(text: widget.title),
          SizedBox(
            height: Dimensions.height10,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
              autofillHints: [
                widget.isEmail
                    ? AutofillHints.email
                    : widget.isPassword
                        ? AutofillHints.password
                        : ''
              ],
              onEditingComplete: widget.isEmail & widget.isPassword
                  ? () => TextInput.finishAutofillContext()
                  : null,
              controller: widget.controller,
              scrollPhysics: const BouncingScrollPhysics(),
              keyboardType:
                  widget.isNumber ? TextInputType.number : TextInputType.text,
              obscureText: widget.isPassword,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.width30),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.4))),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  hintText: widget.placeholder,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.width30)),
                  filled: true,
                  fillColor: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
