import 'package:flutter/material.dart';

class TextFieldCostum extends StatelessWidget {
  final bool obscureText;
  final String hintText;

  const TextFieldCostum({
    Key key,
    @required this.obscureText,
    @required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: TextStyle(fontSize: 20.0),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "${hintText}",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
  }
}
