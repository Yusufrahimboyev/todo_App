import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final void Function(bool?)? onChanged;
  final bool value;

  const TodoList({
    super.key,
    required this.title,
    required this.onTap,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            decoration: value ? TextDecoration.lineThrough : null,
          ),
        ),

        leading: Checkbox(value: value, onChanged: onChanged),
      ),
    );
  }
}
