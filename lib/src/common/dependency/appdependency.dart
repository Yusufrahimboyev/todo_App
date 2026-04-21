import 'package:shared_preferences/shared_preferences.dart';

import '../../features/homescreen/data/todo_repository.dart';

class AppDependency {
  final SharedPreferences shp;
  final TodoRepository todoRepository;

  AppDependency({required this.shp, required this.todoRepository});
}
