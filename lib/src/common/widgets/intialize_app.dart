import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsk_3/src/common/dependency/appdependency.dart';
import 'package:tsk_3/src/features/homescreen/controller/firebase_realtime_controller.dart';

import '../../../firebase_options.dart';
import '../../features/homescreen/controller/firebase_controller.dart';
import '../../features/homescreen/controller/local_controller.dart';

class InitializeApp {
  Future<AppDependency> initialize() async {
    final shp = await SharedPreferences.getInstance();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final firebaseController = IFirebaseController();
    final todoRepository = LocalController(shp);
    final firebaseRealtimeController = IFirebaseRealtimeController();

    return AppDependency(
      shp: shp,
      todoRepository: todoRepository,
      firebaseController: firebaseController,
      firebaseRealtimeController: firebaseRealtimeController,
    );
  }
}
