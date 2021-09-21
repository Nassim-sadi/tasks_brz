import 'dart:math';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasks_brz/models/noteModel.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tasks_brz/screens/noteScreen.dart';
import 'package:tasks_brz/ui/custom_app_bar.dart';
import 'data/lists.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
  // ignore: unused_local_variable

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
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Made With'),
            FlutterLogo(
              style: FlutterLogoStyle.horizontal,
              size: 100,
            ),
          ],
        ),
        nextScreen: const MyHomePage(),
        splashTransition: SplashTransition.rotationTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: const Color(0xfff4f4f4),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle dateStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black);
  TextStyle contentStyle =
      const TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black);

  Random random = Random();

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const NoteScreen();
            }));
          },
          child: const Icon(Icons.note_add),
          backgroundColor: Colors.purple,
        ),
      ),
    );
  }

  Widget noteCard(NoteModel note) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              //cardColors[random.nextInt(cardColors.length)],
              //cardColors[random.nextInt(cardColors.length)],
              cardColors[note.color1],
              cardColors[note.color2],
            ],
          ),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 50,
          ),
          child: Column(children: [
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        note.isImportant ? note.isImportant = false : note.isImportant = true;
                      });
                    },
                    icon: Icon(note.isImportant ? Icons.star : Icons.star_border,
                        color: Colors.indigo),
                  ),
                  Text(DateFormat('KK:mm ,dd-mm-yyyy ').format(note.createdOn), style: dateStyle),
                ],
              ),
            ),
            Text(note.content, style: contentStyle),
          ]),
        ),
      ),
    );
  }
}
