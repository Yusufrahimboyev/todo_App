import 'package:flutter/material.dart';
import 'package:tsk_3/src/features/homescreen/screens/homescreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(

      ),
    );
  }
}
