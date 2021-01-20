import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const DrawerItem({
    this.title,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.changa(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          )),
      trailing: Icon(
        icon,
        color: Colors.tealAccent,
      ),
      onTap: onTap,
    );
  }
}
