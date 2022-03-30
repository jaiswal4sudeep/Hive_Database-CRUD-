import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class ToDoModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  String desc;

  ToDoModel(this.title, this.desc);
}
