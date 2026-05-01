import 'package:tsk_3/src/features/homescreen/model/note.dart';

abstract class TodoRepository {
  const TodoRepository();

  Future<void> addNote(String note, bool value, DateTime createdAt);

  Future<void> deleteNote(int index);

  Future<void> editNote(
    String index,
    String newTxt,
    bool values,
    List<Note> note,
    DateTime createdAt,
  );

  List<Note> getNotes();

  Future<void> deleteAll();

  Stream<List<Note>> get notes;
}
