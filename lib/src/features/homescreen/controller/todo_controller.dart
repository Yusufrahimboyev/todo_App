import 'package:flutter/material.dart';
import 'package:tsk_3/src/features/homescreen/controller/firebase_controller.dart';
import 'package:tsk_3/src/features/homescreen/data/todo_repository.dart';
import 'package:tsk_3/src/features/homescreen/model/note.dart';

abstract class ITodoController with ChangeNotifier {
  Future<void> getData();

  Future<void> addNote(String note, bool value);

  Future<void> deleteNote(int index);

  Future<void> deleteAll();

  Future<void> editNote(int index, String newTxt, bool value);

  List<Note> get notes;
}

class TodoController extends ITodoController {
  late final TodoRepository _todoRepository;
  late final FirebaseController _firebaseController;

  TodoController(this._todoRepository, this._firebaseController)
    : notes = _todoRepository.getNotes();

  @override
  Future<void> addNote(String note, [bool value = false]) async {
    if (note.isEmpty) return;
    _firebaseController.create(
      Note(text: note, isChecked: value, id: notes.length.toString()),
    );
    await _todoRepository.addNote(note, value);
    notes = _todoRepository.getNotes();
    notifyListeners();
  }

  @override
  Future<void> deleteNote(int index) async {
    if (notes.isEmpty) return;
    await _firebaseController.delete(notes[index]);
    await _todoRepository.deleteNote(index);
    getData();
    notifyListeners();
  }

  @override
  Future<void> editNote(int index, String newTxt, bool value) async {
    if (newTxt.isEmpty) return;
    await _todoRepository.editNote(index, newTxt, value, notes);
    await _firebaseController.update(
      Note(text: newTxt, isChecked: value, id: notes[index].id),
    );
    getData();
    notifyListeners();
  }

  @override
  List<Note> notes;

  @override
  Future<void> deleteAll() async {
    notes.clear();
    await _todoRepository.deleteAll();
    await _firebaseController.deleteAll();
    notifyListeners();
  }

  @override
  Future<void> getData() async {
    try {
      notes = await _firebaseController.read();
    } on Object catch (e) {
      notes = _todoRepository.getNotes();
    }
    notifyListeners();
  }
}
