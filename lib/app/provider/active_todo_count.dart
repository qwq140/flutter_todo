import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/provider/todo_list.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;

  const ActiveTodoCountState({this.activeTodoCount = 0});

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [activeTodoCount];

  ActiveTodoCountState copyWith({int? activeTodoCount}) {
    return ActiveTodoCountState(
        activeTodoCount: activeTodoCount ?? this.activeTodoCount);
  }
}

class ActiveTodoCountProvider {
  final TodoListProvider todoList;

  ActiveTodoCountProvider({required this.todoList});

  ActiveTodoCountState get state => ActiveTodoCountState(
        activeTodoCount:
            todoList.state.todoList.where((e) => !e.isDone).toList().length,
      );
}
