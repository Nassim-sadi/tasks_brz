// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasks_brz/data/database.dart';
import 'package:tasks_brz/data/lists.dart';
import 'package:tasks_brz/models/noteModel.dart';
import 'package:tasks_brz/ui/custom_app_bar.dart';

class NoteEdit extends StatefulWidget {
  const NoteEdit({Key? key}) : super(key: key);
  @override
  _NoteEditState createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    NoteModel note = ModalRoute.of(context)!.settings.arguments as NoteModel;
    bool isImportant = note.isImportant == 1 ? true : false;
    myController = TextEditingController(text: note.content);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffF0F8FF),
            Color(0xffF0F8FF),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: myCustomAppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
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
                      isImportant ? Icons.star : Icons.star_border,
                      color: isImportant ? Colors.red : Colors.grey[800],
                      size: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      top: BorderSide(width: 1, color: Colors.grey, style: BorderStyle.solid),
                      bottom: BorderSide(width: 1, color: Colors.grey),
                    )),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: myController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Note content',
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height / 3,
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () async {
                      await DatabaseHelper.instance.delete(note.id!);

                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    icon: Icon(Icons.close, color: Colors.grey[800], size: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          DatabaseHelper.instance.update({
                            DatabaseHelper.noteId: note.id,
                            DatabaseHelper.noteContent: myController.text,
                            DatabaseHelper.noteBool: isImportant,
                            DatabaseHelper.noteCreatedOn: DateTime.now().toIso8601String(),
                          });

                          Navigator.pop(context);
                        });
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.

                      List<NoteModel> result;
                      result = await DatabaseHelper.instance.queryAll();
                      print('the return data from insert is : ${result.length}');
                    },
                    child: const Text('Get Querry'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.

                      await DatabaseHelper.instance.delete(2);

                      print('Deleted');
                    },
                    child: const Text('remove '),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
