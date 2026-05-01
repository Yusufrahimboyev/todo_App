import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tsk_3/src/features/homescreen/model/note.dart';

abstract class FirebaseController {
  Future<void> create(Note note);

  Future<List<Note>> read();

  Future<void> update(Note note);

  Future<void> delete(Note note);

  Future<void> deleteAll();
}

class IFirebaseController extends FirebaseController {
  final firebase = FirebaseFirestore.instance;

  @override
  Future<void> create(Note note) async {
    await firebase.collection("notes").add(note.toMap());
  }

  @override
  Future<void> delete(Note note) async {
    QuerySnapshot querySnapshot = await firebase.collection("notes").get();
    for (var i in querySnapshot.docs) {
      if (Note.fromJson(i.data() as Map<String, Object?>).id == note.id) {
        await i.reference.delete();
      }
    }
  }

  @override
  Future<List<Note>> read() async {
    QuerySnapshot querySnapshot = await firebase.collection("notes").get();
    final modelList = <Note>[];
    for (var i in querySnapshot.docs) {
      modelList.add(Note.fromJson(i.data() as Map<String, Object?>));
    }

    return modelList;
  }

  @override
  Future<void> update(Note note) async {
    QuerySnapshot querySnapshot = await firebase.collection("notes").get();
    for (var i in querySnapshot.docs) {
      if (Note.fromJson(i.data() as Map<String, Object?>).id == note.id) {
        await i.reference.update(note.toMap());
      }
    }
  }

  @override
  Future<void> deleteAll() async {
    QuerySnapshot querySnapshot = await firebase.collection("notes").get();
    for (var i in querySnapshot.docs) {
      await i.reference.delete();
    }
  }
}
