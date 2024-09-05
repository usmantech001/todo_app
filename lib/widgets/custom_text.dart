import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget reusableText(String text,
    {color = Colors.black, size = 25.0, fontweight = FontWeight.w500}) {
  return Text(text,
      style: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: size,
              color: color,
              overflow: TextOverflow.ellipsis,
              fontWeight: fontweight)));
}