import 'package:flutter/material.dart';
import 'package:hive_database/models/todo_model.dart';
import 'package:hive_database/pages/home_page.dart';

createList(todoTitle, todoDesc, context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add ToDo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: todoTitle,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Title'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: todoDesc,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Description'),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            if (todoTitle.text.isNotEmpty && todoDesc.text.isNotEmpty) {
              final String title = todoTitle.text;
              final String description = todoDesc.text;
              todoTitle.clear();
              todoDesc.clear();
              ToDoModel data = ToDoModel(title, description);
              box.add(data);
              Navigator.of(context).pop();
            } else {
              // ignore: avoid_print
              print('Please add data');
            }
          },
          icon: const Icon(Icons.save),
          label: const Text('Save'),
        ),
      ],
    ),
  );
}
