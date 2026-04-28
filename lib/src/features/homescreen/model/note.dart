class Note {
  const Note({required this.text, required this.isChecked, required this.id});
  final String id;
  final String text;
  final bool isChecked;

  static Note fromJson(Map<String, Object?> json) => Note(
    text: json["text"] as String? ?? '',
    isChecked: json["isChecked"] as bool? ?? false,
    id: json["id"] as String? ?? '',
  );

  Map<String, Object?> toMap() => {
    "text": text,
    "isChecked": isChecked,
    "id": id,
  };
}
