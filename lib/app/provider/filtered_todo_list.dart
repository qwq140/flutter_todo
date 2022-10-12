import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/models/todo_model.dart';
import 'package:todo/app/provider/todo_filter.dart';
import 'package:todo/app/provider/todo_list.dart';
import 'package:todo/app/provider/todo_search.dart';

class FilteredTodoListState extends Equatable {
  final List<TodoModel> filteredTodoList;

  FilteredTodoListState({List<TodoModel>? filteredTodoList})
      : filteredTodoList = filteredTodoList ?? [];

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [filteredTodoList];

  FilteredTodoListState copyWith({List<TodoModel>? filteredTodoList}) =>
      FilteredTodoListState(
          filteredTodoList: filteredTodoList ?? this.filteredTodoList);
}

// TodoList, TodoSearch, TodoFilter 필요
class FilteredTodoListProvider {
  final TodoFilterProvider todoFilter;
  final TodoSearchProvider todoSearch;
  final TodoListProvider todoList;

  FilteredTodoListProvider({
    required this.todoFilter,
    required this.todoSearch,
    required this.todoList,
  });

  FilteredTodoListState get state {
    List<TodoModel> _filteredTodoList;

    switch (todoFilter.state.filter) {
      case Filter.active:
        _filteredTodoList =
            todoList.state.todoList.where((e) => !e.isDone).toList();
        break;
      case Filter.completed:
        _filteredTodoList =
            todoList.state.todoList.where((e) => e.isDone).toList();
        break;
      case Filter.all:
      default:
        _filteredTodoList = todoList.state.todoList;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      _filteredTodoList = _filteredTodoList
          .where((e) => e.content.contains(todoSearch.state.searchTerm))
          .toList();
    }

    return FilteredTodoListState(filteredTodoList: _filteredTodoList);
  }
}
