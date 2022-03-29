import 'package:flutter/material.dart';
import 'package:hive_database/todo_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box<ToDoModel> box;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController todoTitle = TextEditingController();
  TextEditingController todoDesc = TextEditingController();

  @override
  void initState() {
    super.initState();
    box = Hive.box<ToDoModel>('todo');
  }

  showPopup() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo-Hive DB'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showPopup();
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Box<ToDoModel> todos, _) {
            var items = todos.values.toList().cast<ToDoModel>();
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text(items[index].title.toString()),
                        subtitle: Text(items[index].desc.toString()),
                        trailing: IconButton(
                          onPressed: () {
                            box.deleteAt(index);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
