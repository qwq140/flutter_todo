import 'package:todo/app/models/todo_model.dart';
import 'package:todo/app/utils/db_helper.dart';

class TodoService {

  static final TodoService _instance = TodoService._internal();

  factory TodoService() => _instance;

  late DBHelper dbHelper;

  TodoService._internal(){
    print('투두서비스 시작');
    dbHelper = DBHelper()..open();
  }

  Future<List<TodoModel>> getAllTodo() async {
    return await dbHelper.getAllTodo();
  }

  Future addTodo(TodoModel todoModel) async {
    return await dbHelper.insert(todoModel);
  }

  Future update(TodoModel todoModel) async {
    return await dbHelper.update(todoModel);
  }

  Future delete(String id) async {
    return await dbHelper.delete(id);
  }

}