import 'package:flutter/material.dart';

AppBar buildAppbar(String title, BuildContext context, bool back) {
  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,
    automaticallyImplyLeading: back,
    centerTitle: true,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(
          fontFamily: 'QuickSand',
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 15),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(25),
      ),
    ),
  );
}
