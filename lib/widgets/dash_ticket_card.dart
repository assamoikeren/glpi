import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DashTicketCard extends StatefulWidget {
  final Color iconColor;
  final Color bgColor;
  final IconData icon;
  final int number;

  DashTicketCard({this.bgColor, this.icon, this.iconColor, this.number});

  @override
  _DashTicketCardState createState() => _DashTicketCardState();
}

class _DashTicketCardState extends State<DashTicketCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        width: 106,
        height: constraints.maxHeight * 0.9,
        padding: EdgeInsets.symmetric(
            vertical: constraints.maxHeight * 0.02, horizontal: 2),
        decoration: BoxDecoration(
          color: Color.fromRGBO(242, 242, 242, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: constraints.maxHeight * 0.35,
              height: constraints.maxHeight * 0.35,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.bgColor,
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: Alignment.center,
              child: Center(
                child: Icon(
                  widget.icon,
                  color: widget.iconColor,
                  size: 22,
                ),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.08,
            ),
            Text(
              widget.number.toString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    });
  }
}
