import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final TextEditingController controller;
  final bool obscure;
  final TextInputType keyboardType;
  final String errorText;
  final Function onChanged;
  final Widget prefix;
  const CustomTextField({
    Key key,
    @required this.hint,
    @required this.iconData,
    this.controller,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.onChanged,
    this.prefix,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const hintStyle = TextStyle(
      color: Color(0xFFDDDDDD),
    );
    const textStyle = TextStyle(color: Colors.white);
    return TextField(
      controller: controller,
      cursorColor: Colors.white,
      style: textStyle,
      obscureText: obscure,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefix: prefix,
        errorText: errorText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(
          iconData,
          color: Theme.of(context).accentColor,
        ),
        hintText: hint,
        hintStyle: hintStyle,
      ),
    );
  }
}
