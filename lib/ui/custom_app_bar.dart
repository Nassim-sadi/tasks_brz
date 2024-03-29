import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

myCustomAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: RichText(
      text: TextSpan(children: [
        TextSpan(
            text: 'Notes',
            style: GoogleFonts.balsamiqSans(
              textStyle: TextStyle(
                  color: MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? const Color(0xfff8e8f8)
                      : const Color(0xff08182b)),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
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
