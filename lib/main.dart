import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasks_brz/models/noteModel.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.balsamiqSansTextTheme(Theme.of(context).textTheme),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> cardColors = const [
    Color(0xfffe4365),
    Color(0xfff1404b),
    Color(0xfffbd14b),
    Color(0xfffc9d9a),
    Color(0xff008c9e),
    Color(0xff7ec5af),
    Color(0xfffec8c9),
    Color(0xffe88479),
  ];
  Random ran = Random();
  List<NoteModel> notes = [
    NoteModel('note number one ', DateTime.now()),
    NoteModel('note number two ', DateTime.now()),
    NoteModel('note number three ', DateTime.now()),
    NoteModel('note number four ', DateTime.now()),
    NoteModel('note number five ', DateTime.now()),
    NoteModel('note number six ', DateTime.now()),
    NoteModel('note number Seven ', DateTime.now()),
    NoteModel('note number Eight ', DateTime.now()),
    NoteModel('note number Nine ', DateTime.now()),
    NoteModel('note number Ten ', DateTime.now()),
    NoteModel('note number eleven ', DateTime.now()),
    NoteModel('note number twelve ', DateTime.now()),
    NoteModel('note number therteen ', DateTime.now()),
    NoteModel('note number fourteen ', DateTime.now()),
    NoteModel('note number fivteen ', DateTime.now()),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xfff4f4f4), Color(0xffe4e7ec)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: myCustomAppBar(),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return noteCard(notes[index]);
          },
          itemCount: notes.length,
        ),
      ),
    );
  }

  Widget noteCard(NoteModel note) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              // colors: [Color(0xff526584), Color(0xff1122ff)],
              colors: [
                cardColors[ran.nextInt(cardColors.length)],
                cardColors[ran.nextInt(cardColors.length)],
              ],
            )),
        height: 100,
        width: double.infinity,
        child: Column(children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              DateFormat('KK:mm ,dd-mm-yyyy ').format(note.time),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8, color: Colors.black),
            ),
          ),
          Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Text(note.content +
                  " Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ")),
        ]),
      ),
    );
  }

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
}
