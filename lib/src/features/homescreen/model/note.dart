import 'dart:convert';

class Note {
  const Note({required this.text, required this.isChecked});

  final String text;
  final bool isChecked;

  static Note fromJson(Map<String, Object?> json) => Note(
    text: json["text"] as String? ?? '',
    isChecked: json["isChecked"] as bool? ?? false,
  );

  String toJson() => jsonEncode({"text": text, "isChecked": isChecked});
}
