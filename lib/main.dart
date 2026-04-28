import 'package:flutter/material.dart';
import 'package:tsk_3/src/common/widgets/app.dart';
import 'package:tsk_3/src/common/widgets/app_scope.dart';
import 'package:tsk_3/src/common/widgets/intialize_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependency = await InitializeApp().initialize();

  runApp(AppScope(dependency: dependency, child: MyApp()));
}
