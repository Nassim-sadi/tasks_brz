// ignore_for_file: file_names
import 'package:intl/intl.dart';

const String notesTable = "Notes";

class NoteFields {
  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String content = 'content';
  static const String createdOn = 'createdOn';
  static const String color1 = 'color1';
  static const String color2 = 'color2';
}

class NoteModel {
  int? id;
  int isImportant;
  String content;
  DateTime createdOn;
  int color1;
  int color2;
  NoteModel({
    this.id,
    required this.isImportant,
    required this.content,
    required this.createdOn,
    required this.color1,
    required this.color2,
  });

  Map<String, dynamic> toMap() {
    return {
      NoteFields.id: id,
      NoteFields.isImportant: isImportant,
      NoteFields.content: content,
      NoteFields.createdOn: createdOn.toString(),
      NoteFields.color1: color1,
      NoteFields.color2: color2,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) => NoteModel(
        id: map[NoteFields.id],
        content: map[NoteFields.content].toString(),
        isImportant: map[NoteFields.isImportant],
        createdOn: DateTime.parse(map[NoteFields.createdOn]),
        color1: map[NoteFields.color1],
        color2: map[NoteFields.color2],
      );
}
