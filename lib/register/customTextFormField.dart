import 'package:flutter/material.dart';
import 'package:todo_list/appColors.dart';

typedef MyValidator = String? Function(String?);

class Customtextformfield extends StatelessWidget {
  String label;
  MyValidator validator;
  TextEditingController controller;
  TextInputType keyboardType;
  bool obscureText;
  Customtextformfield(
      {required this.label, required this.validator, required this.controller,
      this.keyboardType=TextInputType.text,this.obscureText=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Appcolors.primaryColor, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Appcolors.primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Appcolors.redColor, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Appcolors.redColor, width: 2),
            ),
            labelText: label,
          ),
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          obscureText:obscureText,
        ));
  }
}
