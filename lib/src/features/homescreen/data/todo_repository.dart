import 'package:tsk_3/src/features/homescreen/model/note.dart';

abstract class TodoRepository {
  const TodoRepository();

  Future<void> addNote(String note, bool value);

  Future<void> deleteNote(int index);

  Future<void> editNote(int index, String newTxt, bool values, List<Note> note);

  List<Note> getNotes();

  Future<void> deleteAll();
}
