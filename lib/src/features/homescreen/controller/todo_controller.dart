import 'package:flutter/material.dart';
import 'package:tsk_3/src/features/homescreen/data/todo_repository.dart';
import 'package:tsk_3/src/features/homescreen/model/note.dart';

abstract class ITodoController with ChangeNotifier {
  Future<void> addNote(String note, bool value);

  Future<void> deleteNote(int index);

  Future<void> deleteAll();

  Future<void> editNote(int index, String newTxt, bool value);

  List<Note> get notes;
}

class TodoController extends ITodoController {
  late final TodoRepository _todoRepository;

  TodoController(this._todoRepository) : notes = _todoRepository.getNotes();

  @override
  Future<void> addNote(String note, [bool value = false]) async {
    await _todoRepository.addNote(note, value);
    notes = _todoRepository.getNotes();
    notifyListeners();
  }

  @override
  Future<void> deleteNote(int index) async {
    await _todoRepository.deleteNote(index);
    notes = _todoRepository.getNotes();
    notifyListeners();
  }

  @override
  Future<void> editNote(int index, String newTxt, bool value) async {
    if (newTxt.isEmpty) return;
    await _todoRepository.editNote(index, newTxt, value);
    notes = _todoRepository.getNotes();
    notifyListeners();
  }

  @override
  List<Note> notes;

  @override
  Future<void> deleteAll() async {
    notes.clear();
    notifyListeners();
  }
}
