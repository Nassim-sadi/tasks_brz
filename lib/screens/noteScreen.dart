// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasks_brz/data/database.dart';
import 'package:tasks_brz/data/lists.dart';
import 'package:tasks_brz/models/noteModel.dart';
import 'package:tasks_brz/ui/custom_app_bar.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Random random = Random();
  bool isImportant = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffe4e4e4), Color(0xffe4e4e4)],
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
                        isChecked == false ? isChecked = true : isChecked = false;
                      });
                    },
                    icon: Icon(
                      isChecked ? Icons.star : Icons.star_border,
                      color: isChecked ? Colors.red : Colors.grey[800],
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        int color1 = random.nextInt(cardColors.length);
                        int color2 = random.nextInt(cardColors.length);

                        setState(() {
                          DatabaseHelper.instance.insert({
                            DatabaseHelper.noteContent: myController.text,
                            DatabaseHelper.noteBool: isChecked,
                            DatabaseHelper.noteCreatedOn: DateTime.now().toIso8601String(),
                            DatabaseHelper.noteColor1: color1,
                            DatabaseHelper.noteColor2: color2,
                          });
                          NoteModel note = NoteModel(
                              isImportant: isChecked ? 1 : 0,
                              content: myController.text,
                              createdOn: DateTime.now(),
                              color1: color1,
                              color2: color2);
                          Navigator.pop(context, note);
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
