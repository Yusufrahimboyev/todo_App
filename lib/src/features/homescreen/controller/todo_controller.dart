import 'package:flutter/material.dart';
import 'package:tsk_3/src/features/homescreen/controller/firebase_controller.dart';

import 'package:tsk_3/src/features/homescreen/data/todo_repository.dart';
import 'package:tsk_3/src/features/homescreen/model/note.dart';

import 'firebase_realtime_controller.dart';

abstract class ITodoController extends ChangeNotifier {
  Future<void> getData();

  Future<void> addNote(String note, bool value, DateTime? createdAt);

  Future<void> deleteNote(int index);

  Future<void> deleteAll();

  Future<void> editNote(
    int index,
    String newTxt,
    bool value,
    DateTime createdAt,
  );

  List<Note> get notes;
  Stream<List<Note>> get noteStream;
}

class TodoController extends ITodoController {
  late final TodoRepository _todoRepository;
  late final FirebaseController _firebaseController;
  late final FirebaseRealtimeController _firebaseRealtimeController;

  TodoController(
    this._todoRepository,
    this._firebaseController,
    this._firebaseRealtimeController,
  ) : notes = _todoRepository.getNotes();

  @override
  Future<void> addNote(
    String note, [
    bool value = false,
    DateTime? createdAt,
  ]) async {
    if (note.isEmpty) return;

    final newNote = Note(
      text: note,
      isChecked: value,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: (createdAt ?? DateTime.now()).toString(),
    );

    await _firebaseController.create(newNote);
    await _todoRepository.addNote(note, value, createdAt ?? DateTime.now());
    await _firebaseRealtimeController.create(newNote);
    notifyListeners();
  }

  @override
  Future<void> deleteNote(int index) async {
    if (notes.isEmpty) return;
    await _firebaseController.delete(notes[index]);
    await _todoRepository.deleteNote(index);
    await getData();
    notifyListeners();
  }

  @override
  Future<void> editNote(
    int index,
    String newTxt,
    bool value,
    DateTime createdAt,
  ) async {
    if (newTxt.isEmpty) return;
    await _todoRepository.editNote(
      notes[index].id,
      newTxt,
      value,
      notes,
      createdAt,
    );
    await _firebaseController.update(
      Note(
        text: newTxt,
        isChecked: value,
        id: notes[index].id,
        createdAt: createdAt.toString(),
      ),
    );
    notifyListeners();
  }

  @override
  List<Note> notes;

  @override
  Future<void> deleteAll() async {
    notes.clear();
    await _todoRepository.deleteAll();
    await _firebaseController.deleteAll();
    await _firebaseRealtimeController.deleteAll();
    notifyListeners();
  }

  @override
  Future<void> getData() async {
    try {
      notes = await _firebaseRealtimeController.read();
      notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notes.reversed;
    } on Object catch (_) {
      notes = await _firebaseRealtimeController.read();
    }
    notifyListeners();
  }

  @override
  Stream<List<Note>> get noteStream => _firebaseRealtimeController.notes;
}
