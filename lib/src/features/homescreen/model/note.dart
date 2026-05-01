class Note {
  const Note({
    required this.text,
    required this.isChecked,
    required this.id,
    required this.createdAt,
  });
  final String id;
  final String text;
  final String createdAt;
  final bool isChecked;

  static Note fromJson(Map<String, Object?> json) => Note(
    text: json["text"]?.toString() ?? '',
    isChecked: json["isChecked"] as bool? ?? false,
    id: json["id"]?.toString() ?? '',
    createdAt: json["createdAt"]?.toString() ?? '',
  );

  Map<String, Object?> toMap() => {
    "text": text,
    "isChecked": isChecked,
    "id": id,
    "createdAt": createdAt,
  };
}
