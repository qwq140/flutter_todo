import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/models/todo_model.dart';

class TodoListState extends Equatable{
  final List<TodoModel> todoList;

  TodoListState({List<TodoModel>? todoList}) : todoList = todoList ?? [
    TodoModel(id: '1', content: '방청소하기'),
    TodoModel(id: '2', content: '설거지하기'),
    TodoModel(id: '3', content: '공부하기'),
  ];

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [todoList];

  TodoListState copyWith({List<TodoModel>? todoList}) => TodoListState(todoList: todoList ?? this.todoList);
}

class TodoListProvider with ChangeNotifier {
  TodoListState _state = TodoListState();
  TodoListState get state => _state;

  // 투두아이템 추가
  void addTodo(String content){
    final newTodo = TodoModel(content: content);
    final newTodoList = [..._state.todoList, newTodo];

    _state = _state.copyWith(todoList: newTodoList);
    notifyListeners();
  }

  // 투두 내용수정
  void updateContent({required String id, required String content}){
    final newTodoList = _state.todoList.map((e)=> e.id == id ? TodoModel(id: id, content: content, isDone: e.isDone) : e).toList();

    _state = _state.copyWith(todoList: newTodoList);
    notifyListeners();
  }

  // 할일 체크
  void toggle({required String id}){
    final newTodoList = _state.todoList.map((e)=> e.id == id ? TodoModel(id: id, content: e.content, isDone: !e.isDone) : e).toList();

    _state = _state.copyWith(todoList: newTodoList);
    notifyListeners();
  }

  // 목록에서 제거
  void remove({required String id}){
    final newTodoList = _state.todoList.where((e) => e.id != id).toList();

    _state = _state.copyWith(todoList: newTodoList);
    notifyListeners();
  }
}