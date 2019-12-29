import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final List<Color> colors;
  final Color textColor;
  const CustomButton(
      {Key key, this.onPressed, this.text, this.colors, this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          colors: colors ??
              [
                Theme.of(context).buttonColor,
                Theme.of(context).cardColor,
              ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: FlatButton(
        child: Text(
          text ?? "",
          style: TextStyle(
              color: textColor ?? Theme.of(context).primaryColor,
              fontSize: 18,
              fontFamily: "Arial",
              fontWeight: FontWeight.bold),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
