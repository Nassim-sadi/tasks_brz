import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasks_brz/data/database.dart';
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

Future<List<NoteModel>> getAllNotes() async {
  return DatabaseHelper.instance.queryAll();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<AnimatedListState> key = GlobalKey<AnimatedListState>();
  int? _selectedItem;
  TextStyle dateStyle =
      const TextStyle(fontWeight: FontWeight.w100, fontSize: 10, color: Colors.black);
  TextStyle contentStyle =
      const TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black);

  @override
  void initState() {
    super.initState();

      getAllNotes();

  }

  void _addItem(note, List list) {
    list.insert(list.length + 1, note);
    key.currentState!.insertItem(0, duration: const Duration(seconds: 1));
  }

// Remove an item
// This is trigger when the trash icon associated with an item is tapped
  void _removeItem(int index, List list) {
    key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: const Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.purple,
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text("Goodbye", style: TextStyle(fontSize: 24)),
          ),
        ),
      );
    }, duration: const Duration(seconds: 1));

    list.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff0000aa),
            Color(0xff050505),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: myCustomAppBar(),
        body: FutureBuilder<List<NoteModel>>(
            future: getAllNotes(),
            builder: (BuildContext context, AsyncSnapshot<List<NoteModel>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return snapshot.data!.isEmpty
                  ? const Center(
                      child: Text('Add a note by Pressing The add Button below'),
                    )
                  :
                  //  AnimatedList(
                  //     physics: const BouncingScrollPhysics(),
                  //     key: key,
                  //     initialItemCount: snapshot.data!.length,
                  //     itemBuilder: (context, index, animation) =>
                  //         noteCard(snapshot.data![index], index, snapshot.data!),
                  //   );

                  StaggeredGridView.countBuilder(
                      crossAxisCount: 4,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) =>
                          noteCard(snapshot.data![index]),
                      staggeredTileBuilder: (int index) => const StaggeredTile.fit(
                        2,
                      ),
                      crossAxisSpacing: 6.0,
                    );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const NoteScreen();
            })).then((value) {
              setState(() {
                //  _addItem(value);
              });
            });
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.purple,
        ),
      ),
    );
  }

  Widget AnimatedNoteCard(NoteModel note, int index, List<NoteModel> list) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: cardColors[note.color2],
              blurRadius: 15.0,
              spreadRadius: 5.0,
              offset: Offset.zero,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cardColors[note.color1],
              cardColors[note.color2],
            ],
          ),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(DateFormat('KK:mm ,dd-MM-yyyy ').format(note.createdOn),
                        style: dateStyle),
                  ),
                  Flexible(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          note.isImportant == 1 ? note.isImportant = 0 : note.isImportant = 1;
                          DatabaseHelper.instance.update({
                            DatabaseHelper.noteId: note.id,
                            DatabaseHelper.noteBool: note.isImportant,
                          });
                        });
                      },
                      icon: Icon(
                        note.isImportant == 1 ? Icons.star : Icons.star_border,
                        color: note.isImportant == 1 ? Colors.red : Colors.grey[800],
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Text(note.content, style: contentStyle),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () async {
                    await DatabaseHelper.instance.delete(note.id!);

                    setState(() {
                      _removeItem(index, list);
                    });
                  },
                  icon: Icon(Icons.delete_forever, color: Colors.grey[800]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget noteCard(NoteModel note) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: cardColors[note.color2],
              blurRadius: 15.0,
              spreadRadius: 5.0,
              offset: Offset.zero,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cardColors[note.color1],
              cardColors[note.color2],
            ],
          ),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(DateFormat('KK:mm ,dd-MM-yyyy ').format(note.createdOn),
                        style: dateStyle),
                  ),
                  Flexible(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          note.isImportant == 1 ? note.isImportant = 0 : note.isImportant = 1;
                          DatabaseHelper.instance.update({
                            DatabaseHelper.noteId: note.id,
                            DatabaseHelper.noteBool: note.isImportant,
                          });
                        });
                      },
                      icon: Icon(
                        note.isImportant == 1 ? Icons.star : Icons.star_border,
                        color: note.isImportant == 1 ? Colors.red : Colors.grey[800],
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Text(note.content, style: contentStyle),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () async {
                    await DatabaseHelper.instance.delete(note.id!);

                    setState(() {
                      // _removeItem(index);
                    });
                  },
                  icon: Icon(Icons.delete_forever, color: Colors.grey[800]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
