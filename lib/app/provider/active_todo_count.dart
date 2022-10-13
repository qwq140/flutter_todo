import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:todo/app/models/todo_model.dart';
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

class ActiveTodoCountProvider extends StateNotifier<ActiveTodoCountState> with LocatorMixin{
  ActiveTodoCountProvider() : super(const ActiveTodoCountState());

  @override
  void update(Locator watch) {
    final List<TodoModel> todoList = watch<TodoListState>().todoList;

    state = state.copyWith(activeTodoCount: todoList.where((e) => !e.isDone).toList().length);

    super.update(watch);
  }
}
