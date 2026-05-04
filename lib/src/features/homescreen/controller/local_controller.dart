import 'dart:convert';
import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsk_3/src/features/homescreen/data/todo_repository.dart';
import 'package:tsk_3/src/features/homescreen/model/note.dart';

class LocalController extends TodoRepository {
  final SharedPreferences _shp;

  LocalController(this._shp);

  static const String _notes = "notes";

  @override
  Future<void> addNote(String note, bool value, DateTime createdAt) async {
    final notes = (_shp.getStringList(_notes) ?? [])
        .map((e) => Note.fromJson(jsonDecode(e)))
        .toList();

    notes.add(
      Note(
        text: note,
        isChecked: value,
        id: notes.length.toString(),
        createdAt: createdAt.toString(),
      ),
    );

    await _shp.setStringList(
      _notes,
      notes.map((e) => jsonEncode(e.toMap())).toList(),
    );
  }

  @override
  Future<void> deleteNote(Note note) async {
    final modelList = getNotes();
    modelList.removeWhere((element) => element.id == note.id);
    final jsonList = <String>[];
    for (final i in modelList) {
      jsonList.add(jsonEncode(i.toMap()));
    }
    await _shp.setStringList(_notes, jsonList);
  }

  @override
  Future<void> editNote(
    String id,
    String newTxt,
    bool value,
    DateTime createdAt,
  ) async {
    final modelList = getNotes();
    final index = modelList.indexWhere((element) => element.id == id);
    if (index != -1) {
      modelList[index] = Note(
        text: newTxt,
        isChecked: value,
        id: id,
        createdAt: createdAt.toString(),
      );

      final jsonList = <String>[];
      for (final i in modelList) {
        jsonList.add(jsonEncode(i.toMap()));
      }
      await _shp.setStringList(_notes, jsonList);
    }
  }

  @override
  List<Note> getNotes() {
    final notes = _shp.getStringList(_notes) ?? [];
    final modelList = <Note>[];
    for (final i in notes) {
      modelList.add(Note.fromJson(jsonDecode(i)));
    }
    return modelList;
  }

  @override
  Future<void> deleteAll() async {
    await _shp.remove(_notes);
  }

  @override
  Stream<List<Note>> get notes {
    return Stream.value(getNotes());
  }
}
