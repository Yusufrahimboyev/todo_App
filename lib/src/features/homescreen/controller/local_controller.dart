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
  Future<void> addNote(String note, bool value) async {
    final notes = (_shp.getStringList(_notes) ?? [])
        .map((e) => Note.fromJson(jsonDecode(e)))
        .toList();

    notes.add(Note(text: note, isChecked: value, id: notes.length.toString()));

    await _shp.setStringList(
      _notes,
      notes.map((e) => jsonEncode(e.toMap())).toList(),
    );
  }

  @override
  Future<void> deleteNote(int index) async {
    final notes = _shp.getStringList(_notes) ?? [];
    final modelList = <Note>[];
    for (final i in notes) {
      modelList.add(Note.fromJson(jsonDecode(i)));
    }
    modelList.removeAt(index);
    final jsonList = <String>[];
    for (final i in modelList) {
      jsonList.add(jsonEncode(i.toMap()));
    }
    await _shp.setStringList(_notes, jsonList);
  }

  @override
  Future<void> editNote(
    int index,
    String newTxt,
    bool value,
    List<Note> notes,
  ) async {
    final modelList = <Note>[];
    for (final i in notes) {
      modelList.add(i);
    }
    modelList[index] = Note(
      text: newTxt,
      isChecked: value,
      id: modelList[index].id,
    );

    final jsonList = <String>[];
    for (final i in modelList) {
      jsonList.add(jsonEncode(i.toMap()));
    }
    await _shp.setStringList(_notes, jsonList);
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
}
