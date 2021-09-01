import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DashCard extends StatefulWidget {
  final String title;
  final String text;
  final IconData icon;

  DashCard({this.icon, this.title, this.text});

  @override
  _DashCardState createState() => _DashCardState();
}

class _DashCardState extends State<DashCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        width: 155,
        height: constraints.maxHeight * 0.94,
        padding: EdgeInsets.symmetric(
            vertical: constraints.maxHeight * 0.03, horizontal: 2),
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: Colors.white,
            ),
            SizedBox(
              height: 4,
            ),
            FittedBox(
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            FittedBox(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
