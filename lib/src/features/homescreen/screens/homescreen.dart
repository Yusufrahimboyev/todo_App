import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
      ),

      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text("data"),
          leading: Checkbox(value: true, onChanged: (_) {}),
        ),
        itemCount: 20,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
