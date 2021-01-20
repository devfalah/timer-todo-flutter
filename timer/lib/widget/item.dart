import 'package:flutter/material.dart';

class BuildItemTimer extends StatelessWidget {
  final double dw;
  final Color color;
  final String imgUrl;
  final String text;
  final Function onTap;

  BuildItemTimer({this.dw, this.color, this.imgUrl, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: color,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: dw * 0.33,
              height: 150,
              child: Image.asset(imgUrl),
            ),
            Text(
              text,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
