import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

myCustomAppBar() {
  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: RichText(
      text: TextSpan(children: [
        TextSpan(
            text: 'Tasks',
            style: GoogleFonts.balsamiqSans(
                textStyle: const TextStyle(
              color: Color(0xff08182b),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ))),
        TextSpan(
            text: 'BRZ',
            style: GoogleFonts.balsamiqSans(
                textStyle: const TextStyle(
              color: Color(0xfff1404b),
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ))),
      ]),
    ),
  );
}
