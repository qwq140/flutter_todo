import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:todo/app/models/todo_model.dart';
import 'package:todo/app/service/todo_service.dart';

enum TodoStatus {
  init,
  loading,
  loaded,
}

class TodoListState extends Equatable{
  final List<TodoModel> todoList;
  final TodoStatus status;

  TodoListState({required this.todoList, required this.status});

  factory TodoListState.initial() => TodoListState(todoList: [], status: TodoStatus.init);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [todoList];

  TodoListState copyWith({List<TodoModel>? todoList, TodoStatus? status}) => TodoListState(todoList: todoList ?? this.todoList, status: status ?? this.status);
}

class TodoListProvider extends StateNotifier<TodoListState> {
  TodoListProvider() : super(TodoListState.initial());

  final TodoService todoService = TodoService();

  void initTodo() async {
    state = state.copyWith(status: TodoStatus.loading);
    final todoList = await todoService.getAllTodo();
    state = state.copyWith(todoList: todoList, status: TodoStatus.loaded);
  }

  // 투두아이템 추가
  void addTodo(String content){
    final newTodo = TodoModel(content: content);
    final newTodoList = [...state.todoList, newTodo];

    todoService.addTodo(newTodo);
    state = state.copyWith(todoList: newTodoList);
  }

  // 투두 내용수정
  void updateContent({required String id, required String content}){
    final newTodoList = state.todoList.map((e){
      if(e.id == id){
        e = TodoModel(id: id, content: content, isDone: e.isDone);
        todoService.update(e);
      }
      return e;
    }).toList();

    state = state.copyWith(todoList: newTodoList);
  }

  // 할일 체크
  void toggle({required String id}){
    final newTodoList = state.todoList.map((e){
      if(e.id == id){
        e = TodoModel(id: id, content: e.content, isDone: !e.isDone);
        todoService.update(e);
      }
      return e;
    }).toList();

    state = state.copyWith(todoList: newTodoList);
  }

  // 목록에서 제거
  void remove({required String id}){
    final newTodoList = state.todoList.where((e){
      bool temp = e.id != id;
      if(!temp){
        todoService.delete(id);
      }
      return temp;
    }).toList();

    state = state.copyWith(todoList: newTodoList);
  }
}