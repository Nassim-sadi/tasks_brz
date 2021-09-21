// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tasks_brz/data/database.dart';
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

  bool isImportant = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: myCustomAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextFormField(
                  controller: myController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Checkbox(
                  value: isImportant,
                  onChanged: (value) {
                    setState(() {
                      if (isImportant == false) {
                        isImportant = value!;
                      } else {
                        isImportant = value!;
                      }
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        DatabaseHelper.instance.insert({
                          DatabaseHelper.noteContent: myController.text,
                          DatabaseHelper.noteBool: isImportant,
                          DatabaseHelper.noteCreatedOn: DateTime.now().toIso8601String(),
                          DatabaseHelper.noteColor1: 1,
                          DatabaseHelper.noteColor2: 3,
                        });
                        Navigator.pop(context, true);
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
                    await DatabaseHelper.instance.delete(3);
                    await DatabaseHelper.instance.delete(4);
                    await DatabaseHelper.instance.delete(5);
                    await DatabaseHelper.instance.delete(6);
                    await DatabaseHelper.instance.delete(7);

                    print('Deleted');
                  },
                  child: const Text('remove '),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}