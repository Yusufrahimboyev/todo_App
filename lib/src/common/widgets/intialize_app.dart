import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsk_3/src/common/dependency/appdependency.dart';

class InitializeApp {
  Future<AppDependency> initialize() async {
    final shp = await SharedPreferences.getInstance();
    return AppDependency(shp: shp);
  }
}
