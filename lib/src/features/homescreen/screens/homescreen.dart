import 'package:flutter/material.dart';
import 'package:tsk_3/src/common/utils/context_extension.dart';
import 'package:tsk_3/src/common/widgets/todo_list.dart';

import '../controller/todo_controller.dart';
import '../model/note.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late final ITodoController _todoController;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();

    _todoController = TodoController(
      context.dependencies.todoRepository,
      context.dependencies.firebaseController,
      context.dependencies.firebaseRealtimeController,
    );
    _todoController.getData();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _todoController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _todoController.deleteAll,
            icon: Icon(Icons.delete_forever),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Add Note"),
              content: TextField(
                controller: _controller,
                autofocus: true,
                decoration: InputDecoration(hintText: "Add new notes"),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _controller.clear();
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    _todoController.addNote(
                      _controller.text,
                      false,
                      DateTime.now(),
                    );

                    Navigator.pop(context);
                    _controller.clear();
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _todoController.getData,
        child: StreamBuilder<List<Note>>(
          stream: _todoController.noteStream,
          builder: (context, snapshot) {
            final noteList = snapshot.data ?? _todoController.notes;
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) => TodoList(
                onChanged: (_) {
                  _todoController.editNote(
                    index,
                    noteList[index].text,
                    !noteList[index].isChecked,
                    DateTime.now(),
                  );
                },
                title: noteList[index].text,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Delete Note"),
                      content: TextField(
                        controller: _controller,
                        autofocus: true,
                        decoration: InputDecoration(hintText: "Edit"),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _controller.clear();
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            _todoController.editNote(
                              index,
                              _controller.text,
                              noteList[index].isChecked,
                              DateTime.now(),
                            );
                            Navigator.pop(context);
                            _controller.clear();
                          },
                          child: Text("edit"),
                        ),
                        TextButton(
                          onPressed: () {
                            _todoController.deleteNote(index);
                            Navigator.pop(context);
                            _controller.clear();
                          },
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  );
                },
                value: noteList[index].isChecked,
              ),
              itemCount: noteList.length,
            );
          },
        ),
      ),
    );
  }
}
