import 'package:flutter/material.dart';

class PopListTileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  const PopListTileWidget({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Icon(icon),
      title: Text('${title}', style: TextStyle(color: Colors.black),),
      trailing: Icon(icon, color: Colors.black,),
      onTap: onTap,
      dense: true,
    );
  }
}