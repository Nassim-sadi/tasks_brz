// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:NotesBRZ/data/database.dart';
import 'package:NotesBRZ/data/lists.dart';
import 'package:NotesBRZ/models/noteModel.dart';
import 'package:NotesBRZ/ui/custom_app_bar.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  int _color1 = 1;
  int _color2 = 1;
  Random rndm = Random();
  bool isImportant = false;
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
    _color1 = rndm.nextInt(cardColors.length);
    _color2 = rndm.nextInt(cardColors.length);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  var _textAlign = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_formKey.currentState!.validate()) {
          setState(() {
            DatabaseHelper.instance.insert({
              DatabaseHelper.noteContent: myController.text,
              DatabaseHelper.noteBool: isChecked,
              DatabaseHelper.noteCreatedOn: DateTime.now().toIso8601String(),
              DatabaseHelper.noteColor1: _color1,
              DatabaseHelper.noteColor2: _color2,
            });

            Navigator.pop(context);
          });
        } else {
          Navigator.pop(context);
        }
        return true;
      },
      child: Scaffold(
        appBar: myCustomAppBar(context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: isChecked ? cardColors[_color2] : Colors.transparent,
                      blurRadius: 5.0,
                      spreadRadius: 5.0,
                      offset: Offset.zero,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      cardColors[_color1],
                      cardColors[_color2],
                    ],
                  ),
                ),
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
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        textAlign: _textAlign,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: myController,
                        autofocus: true,
                        enableInteractiveSelection: true,
                        onChanged: (value) {
                          if (value == '') {
                            setState(() {
                              _textAlign = TextAlign.left;
                            });
                          } else {
                            if (value[0].contains(RegExp(r'[ا-ي]'))) {
                              setState(() {
                                _textAlign = TextAlign.right;
                              });
                              // myController = TextEditingController(text: '');
                            } else if (!value[0].contains(RegExp(r'[ا-ي]'))) {
                              setState(() {
                                _textAlign = TextAlign.left;
                              });
                            }
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Note content',
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * 0.66,
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
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Transform.translate(
          offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
                color: MediaQuery.of(context).platformBrightness == Brightness.dark
                    ? const Color.fromRGBO(10, 10, 10, 100)
                    : const Color.fromRGBO(255, 255, 255, 100)),
            child: Row(
              children: [
                TextButton(
                  onPressed: () async {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        DatabaseHelper.instance.insert({
                          DatabaseHelper.noteContent: myController.text,
                          DatabaseHelper.noteBool: isChecked,
                          DatabaseHelper.noteCreatedOn: DateTime.now().toIso8601String(),
                          DatabaseHelper.noteColor1: _color1,
                          DatabaseHelper.noteColor2: _color2,
                        });

                        Navigator.pop(context);
                      });
                    }
                  },
                  child: const Text('Submit'),
                ),
                const Spacer(),
                Text(
                  'Edited ' + DateFormat('kk:mm dd/MM/yyyy').format(DateTime.now()),
                  style: TextStyle(
                      color: MediaQuery.of(context).platformBrightness == Brightness.dark
                          ? const Color(0xfff8e8f8)
                          : const Color(0xff08182b)),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  icon: Icon(Icons.close,
                      color: MediaQuery.of(context).platformBrightness == Brightness.dark
                          ? const Color(0xfff8e8f8)
                          : const Color(0xff08182b),
                      size: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
