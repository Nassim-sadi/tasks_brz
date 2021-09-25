// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_brz/data/database.dart';
import 'package:tasks_brz/models/noteModel.dart';
import 'package:tasks_brz/ui/custom_app_bar.dart';
import 'package:tasks_brz/data/lists.dart';

class NoteEdit extends StatefulWidget {
  final NoteModel note;
  const NoteEdit({Key? key, required this.note}) : super(key: key);
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
    bool isImportant = widget.note.isImportant == 1 ? true : false;
    myController = TextEditingController(text: widget.note.content);
    return Scaffold(
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
                    color: cardColors[widget.note.color2],
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
                    cardColors[widget.note.color1],
                    cardColors[widget.note.color2],
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(DateFormat('KK:mm dd-MM-yyyy').format(widget.note.createdOn),
                            style: const TextStyle(fontSize: 12)),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.note.isImportant == 1
                                ? widget.note.isImportant = 0
                                : widget.note.isImportant = 1;
                            DatabaseHelper.instance.update({
                              DatabaseHelper.noteId: widget.note.id,
                              DatabaseHelper.noteBool: widget.note.isImportant,
                            });
                          });
                        },
                        icon: Icon(
                          isImportant ? Icons.star : Icons.star_border,
                          color: isImportant ? Colors.grey.shade900 : Colors.grey.shade800,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 50,
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_left),
                          label: const Text('Back')),
                      ElevatedButton(
                        onPressed: () async {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              DatabaseHelper.instance.update({
                                DatabaseHelper.noteId: widget.note.id,
                                DatabaseHelper.noteContent: myController.text,
                                DatabaseHelper.noteBool: isImportant,
                                DatabaseHelper.noteCreatedOn: DateTime.now().toIso8601String(),
                              });

                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Text('Save'),
                      ),
                      IconButton(
                        onPressed: () async {
                          await DatabaseHelper.instance.delete(widget.note.id!);

                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        icon: Icon(Icons.close, color: Colors.grey[800], size: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
