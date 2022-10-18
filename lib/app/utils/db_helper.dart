import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/app/models/todo_model.dart';

class DBHelper {
  Database? _db;

  Future<Database> get db async {
    if(_db != null) return _db!;

    return await open();
  }

  Future open() async {
    return await openDatabase(join(await getDatabasesPath(), 'todo.db'),
        onCreate: (db, version) => db.execute(
            "CREATE TABLE todo(id TEXT PRIMARY KEY, content TEXT NOT NULL, isDone INTEGER NOT NULL)"),
        version: 1);
  }

  Future<TodoModel> insert(TodoModel todo) async {
    Database database = await db;
    await database.insert('todo', todo.toMap());
    return todo;
  }

  Future<List<TodoModel>> getAllTodo() async {
    Database database = await db;
    final List<Map<String, dynamic>> maps = await database.query('todo');
    return List.generate(maps.length, (index) => TodoModel.fromMap(maps[index]));
  }

  Future<TodoModel?> getTodo(String id) async {
    Database database = await db;
    List<Map> maps = await database.query('todo',
        columns: ['id', 'content', 'isDone'],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return TodoModel.fromMap(maps.first as Map<String, dynamic>);
    }
    return null;
  }

  Future<int> delete(String id) async {
    Database database = await db;
    return await database.delete('todo', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(TodoModel todo) async {
    Database database = await db;
    return await database.update('todo', todo.toMap(),
        where: 'id = ?', whereArgs: [todo.id]);
  }

  Future close() async {
    Database database = await db;
    database.close();
  }
}