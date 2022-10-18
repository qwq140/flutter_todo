import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

enum Filter {
  all, active, completed,
}

class TodoModel extends Equatable{
  final String id;
  final String content;
  final bool isDone;

  TodoModel({String? id, required this.content, this.isDone = false}) : id = id ?? uuid.v4();

  @override
  List<Object?> get props => [id, content, isDone];

  @override
  bool get stringify => true;

  TodoModel.fromMap(Map<String, dynamic> map) : id = map["id"], content = map["content"], isDone = map["isDone"] == 1;

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "id" : id,
      "content" : content,
      "isDone" : isDone ? 1 : 0,
    };
    return map;
  }
}