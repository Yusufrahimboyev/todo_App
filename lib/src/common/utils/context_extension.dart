import 'package:flutter/cupertino.dart';
import 'package:tsk_3/src/common/dependency/appdependency.dart';
import 'package:tsk_3/src/common/widgets/app_scope.dart';

extension ContextExtension on BuildContext {
  AppDependency get dependencies =>
      findAncestorStateOfType<AppScopeState>()!.dependency;
}
