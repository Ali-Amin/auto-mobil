import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final TextEditingController controller;
  final bool obscure;
  const CustomTextField({
    Key key,
    this.obscure = false,
    @required this.hint,
    @required this.iconData,
    @required this.controller,
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
      decoration: InputDecoration(
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
