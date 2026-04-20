import 'package:flutter/material.dart';

import '../dependency/appdependency.dart';

class AppScope extends StatefulWidget {
  final Widget child;
  final AppDependency dependency;

  const AppScope({super.key, required this.child, required this.dependency});

  @override
  State<AppScope> createState() => _AppScopeState();
}

class _AppScopeState extends State<AppScope> {
  late final AppDependency dependency;
  @override
  initState() {
    super.initState();
    dependency = widget.dependency;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
