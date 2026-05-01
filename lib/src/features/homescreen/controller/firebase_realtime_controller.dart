import 'package:firebase_database/firebase_database.dart';
import 'package:tsk_3/src/features/homescreen/model/note.dart';

abstract class FirebaseRealtimeController {
  Future<void> create(Note note);

  Future<List<Note>> read();

  Future<void> update(Note note);

  Future<void> delete(Note note);

  Future<void> deleteAll();

  Stream<List<Note>> get notes;
}

class IFirebaseRealtimeController extends FirebaseRealtimeController {
  final _database = FirebaseDatabase.instance.ref().child("notes");
  @override
  Future<void> create(Note note) async {
    await _database.child(note.id).set(note.toMap());
  }

  @override
  Future<void> delete(Note note) async {
    await _database.child(note.id).remove();
  }

  @override
  Future<void> deleteAll() async {
    await _database.remove();
  }

  @override
  Future<List<Note>> read() async {
    DatabaseEvent event = await _database.once();
    final modelList = <Note>[];

    if (event.snapshot.value != null) {
      for (var i in event.snapshot.children) {
        final data = Map<String, dynamic>.from(i.value as Map);
        modelList.add(Note.fromJson(data));
      }
    }

    return modelList;
  }

  @override
  Future<void> update(Note note) async {
    await _database.child(note.id).update(note.toMap());
  }

  @override
  Stream<List<Note>> get notes => _database.onValue.map((event) {
    final modelList = <Note>[];
    for (var i in event.snapshot.children) {
      final data = Map<String, dynamic>.from(i.value as Map);
      modelList.add(Note.fromJson(data));
    }
    return modelList;
  });
}
