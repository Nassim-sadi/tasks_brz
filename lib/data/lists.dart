import 'package:flutter/material.dart';

import '../models/noteModel.dart';

List<Color> cardColors = const [
  Color(0xfffe4365),
  Color(0xffff9a9e),
  Color(0xffF25283),
  Color(0xfffbd14b),
  Color(0xff008c9e),
  Color(0xff4A98F0),
  Color(0xff69EB70),
  Color(0xff5BF584),
  Color(0xff53DBCF),
  Color(0xffF56A36),
  Color(0xff4AF0B9),
  Color(0xffDB5E56),
  Color(0xff8C47E6),
  Color(0xffEB44CE),
  Color(0xffF27652),
  Color(0xffDB3641),
  Color(0xffF5D538),
  Color(0xffB5EB86),
  Color(0xffe88479),
];

List<NoteModel> notes = [
  NoteModel(
    id: 1,
    isImportant: 1,
    content: 'note number one ',
    createdOn: DateTime.now(),
    color1: 2,
    color2: 7,
  ),
  NoteModel(
    id: 2,
    isImportant: 0,
    content: 'note number two ',
    createdOn: DateTime.now(),
    color1: 5,
    color2: 6,
  ),
  NoteModel(
    id: 3,
    isImportant: 1,
    content: 'note number three ',
    createdOn: DateTime.now(),
    color1: 1,
    color2: 5,
  ),
  NoteModel(
    id: 4,
    isImportant: 0,
    content: 'note number four ',
    createdOn: DateTime.now(),
    color1: 6,
    color2: 1,
  ),
  NoteModel(
    id: 5,
    isImportant: 1,
    content: 'note number five ',
    createdOn: DateTime.now(),
    color1: 7,
    color2: 5,
  ),
  NoteModel(
    id: 6,
    isImportant: 0,
    content: 'note number six ',
    createdOn: DateTime.now(),
    color1: 2,
    color2: 6,
  ),
  NoteModel(
    id: 7,
    isImportant: 1,
    content: 'note number Seven ',
    createdOn: DateTime.now(),
    color1: 6,
    color2: 1,
  ),
  NoteModel(
    id: 8,
    isImportant: 0,
    content: 'note number Eight ',
    createdOn: DateTime.now(),
    color1: 4,
    color2: 3,
  ),
  NoteModel(
    id: 9,
    isImportant: 1,
    content: 'note number Nine ',
    createdOn: DateTime.now(),
    color1: 7,
    color2: 4,
  ),
  NoteModel(
    id: 10,
    isImportant: 0,
    content: 'note number Ten ',
    createdOn: DateTime.now(),
    color1: 5,
    color2: 2,
  ),
  NoteModel(
    id: 11,
    isImportant: 0,
    content: 'note number eleven ',
    createdOn: DateTime.now(),
    color1: 1,
    color2: 7,
  ),
  NoteModel(
    id: 12,
    isImportant: 1,
    content: 'note number twelve ',
    createdOn: DateTime.now(),
    color1: 3,
    color2: 4,
  ),
  NoteModel(
    id: 13,
    isImportant: 1,
    content: 'note number therteen ',
    createdOn: DateTime.now(),
    color1: 6,
    color2: 2,
  ),
];
