import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsk_3/src/common/dependency/appdependency.dart';


import '../../features/homescreen/controller/local_controller.dart';

class InitializeApp {
  Future<AppDependency> initialize() async {
    final shp = await SharedPreferences.getInstance();
    final todoRepository = LocalController(shp);
    return AppDependency(shp: shp, todoRepository: todoRepository);
  }
}
