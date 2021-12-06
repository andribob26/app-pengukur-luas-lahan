import 'package:flutter/material.dart';

class ButtonCostum extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final IconData icon;


  const ButtonCostum({
    Key key,
    @required this.text,
    @required this.color,
    @required this.textColor,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(minWidth: MediaQuery.of(context).size.width),
      child: ElevatedButton.icon(
        icon: Icon(
            icon,
            color: textColor,
            size: 30.0,
          ),
        onPressed: () => print("it's pressed"),
        style: ElevatedButton.styleFrom(
          primary: color,
          onPrimary: textColor,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ), label: Text(
          "${text}",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}