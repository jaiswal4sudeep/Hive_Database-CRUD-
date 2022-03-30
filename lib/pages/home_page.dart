import 'package:flutter/material.dart';
import 'package:hive_database/CRUD/create_list.dart';
import 'package:hive_database/CRUD/delete_list.dart';
import 'package:hive_database/CRUD/update_list.dart';
import 'package:hive_database/models/todo_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo-Hive DB'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createList(todoTitle, todoDesc, context);
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<ToDoModel> todos, _) {
          var items = todos.values.toList().cast<ToDoModel>();
          if (items.isNotEmpty) {
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  child: items.isEmpty
                      ? const Center(
                          child: Text(
                            'No Data has been added yet',
                          ),
                        )
                      : Card(
                          child: ListTile(
                            title: Text(items[index].title.toString()),
                            subtitle: Text(items[index].desc.toString()),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      String title =
                                          items[index].title.toString();
                                      String desc =
                                          items[index].desc.toString();
                                      updateList(
                                        todoTitle,
                                        todoDesc,
                                        title,
                                        desc,
                                        index,
                                        context,
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deleteList(index);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'No data has been added yet.',
              ),
            );
          }
        },
      ),
    );
  }
}
