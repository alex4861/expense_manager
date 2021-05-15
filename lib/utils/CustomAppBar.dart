import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, this.title = ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title, style: TextStyle(fontFamily: 'Avenir', fontWeight: FontWeight.bold)),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            )
        )
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
