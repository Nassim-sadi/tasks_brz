// ignore_for_file: file_names

const String notesTable = "Notes";

class NoteFields {
  static const String id = "_id";
  static const String isImportant = "isImportant";
  static const String content = "content";
  static const String createdOn = "createdOn";
  static const String color1 = "color1";
  static const String color2 = "color2";
}

class NoteModel {
  int? id;
  bool isImportant;
  String content;
  DateTime createdOn;
  int color1;
  int color2;
  NoteModel(
    this.id, {
    required this.isImportant,
    required this.content,
    required this.createdOn,
    required this.color1,
    required this.color2,
  });

  //!!important ----this is for the first sqlite tutorial with copy method that didn't work for some reason
  // NoteModel copy({
  //   int? id,
  //   bool? isImportant,
  //   String? content,
  //   DateTime? time,
  //   int? color1,
  //   int? color2,
  // }) =>
  //     NoteModel(
  //       id: id ?? this.id,
  //       isImportant: isImportant ?? this.isImportant,
  //       content: content ?? this.content,
  //       time: time ?? this.time,
  //       color1: color1 ?? this.color1,
  //       color2: color2 ?? this.color2,
  //     );
  Map<String, dynamic> toMap() {
    return {
      NoteFields.id: id,
      NoteFields.isImportant: isImportant,
      NoteFields.content: content,
      NoteFields.createdOn: createdOn.toIso8601String(),
      NoteFields.color1: color1,
      NoteFields.color2: color2,
    };
  }

  @override
  String toString() {
    return 'notes  {id :$id ,isImportant :$isImportant , content : $content , time : $createdOn}';
  }
}
