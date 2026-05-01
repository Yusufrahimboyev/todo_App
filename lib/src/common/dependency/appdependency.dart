import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsk_3/src/features/homescreen/controller/firebase_controller.dart';
import 'package:tsk_3/src/features/homescreen/controller/firebase_realtime_controller.dart';

import '../../features/homescreen/data/todo_repository.dart';

class AppDependency {
  final SharedPreferences shp;
  final TodoRepository todoRepository;
  final FirebaseController firebaseController;
  final FirebaseRealtimeController firebaseRealtimeController;

  AppDependency({
    required this.shp,
    required this.todoRepository,
    required this.firebaseController,
    required this.firebaseRealtimeController,
  });
}
