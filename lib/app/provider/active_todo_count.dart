import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/provider/todo_list.dart';

class ActiveTodoCountState extends Equatable{
  final int activeTodoCount;

  const ActiveTodoCountState({this.activeTodoCount = 0});

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [activeTodoCount];

  ActiveTodoCountState copyWith({int? activeTodoCount}){
    return ActiveTodoCountState(activeTodoCount: activeTodoCount ?? this.activeTodoCount);
  }
}

class ActiveTodoCountProvider with ChangeNotifier {
  // ActiveTodoCountState _state = const ActiveTodoCountState();
  final int initActiveTodoCount;

  late ActiveTodoCountState _state;
  ActiveTodoCountState get state => _state;

  ActiveTodoCountProvider({required this.initActiveTodoCount}){
    _state = ActiveTodoCountState(activeTodoCount: initActiveTodoCount);
  }

  // 의존하는 값 처음 생성시 호출
  // 의존하는 값 변경시 호출
  void update(TodoListProvider todoList) {
    final int newActiveTodoCount = todoList.state.todoList.where((e) => !e.isDone).toList().length;

    _state = _state.copyWith(activeTodoCount: newActiveTodoCount);
    notifyListeners();
  }
}