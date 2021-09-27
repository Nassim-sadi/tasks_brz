// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
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
  bool isImportant = false;
  @override
  void initState() {
    super.initState();
    isImportant = widget.note.isImportant == 1 ? true : false;
    myController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Random random = Random();
  var _textAlign = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Validate will return true if the form is valid, or false if
        // the form is invalid.
        if (_formKey.currentState!.validate()) {
          setState(() {
            DatabaseHelper.instance.update({
              DatabaseHelper.noteId: widget.note.id,
              DatabaseHelper.noteContent: myController.text,
              DatabaseHelper.noteBool: isImportant,
              DatabaseHelper.noteCreatedOn: DateTime.now().toIso8601String(),
              DatabaseHelper.noteColor1: widget.note.color1,
              DatabaseHelper.noteColor2: widget.note.color2,
            });

            Navigator.pop(context);
          });
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
                      color: widget.note.isImportant == 1
                          ? cardColors[widget.note.color2]
                          : Colors.transparent,
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
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        textAlign: _textAlign,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: myController,
                        autofocus: true,
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
                        enableInteractiveSelection: true,
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
                const Spacer(),
                Text(
                  'Edited ' + DateFormat('kk:mm dd/MM/yyyy').format(widget.note.createdOn),
                  style: TextStyle(
                      color: MediaQuery.of(context).platformBrightness == Brightness.dark
                          ? const Color(0xfff8e8f8)
                          : const Color(0xff08182b)),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    await DatabaseHelper.instance.delete(widget.note.id!);

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
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
