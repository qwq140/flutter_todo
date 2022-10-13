import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:todo/app/models/todo_model.dart';

class TodoFilterState extends Equatable{
  final Filter filter;
  const TodoFilterState({this.filter = Filter.all});

  @override
  List<Object> get props => [filter];

  @override
  bool get stringify => true;

  TodoFilterState copyWith({Filter? filter}){
    return TodoFilterState(filter: filter ?? this.filter);
  }
}

class TodoFilterProvider extends StateNotifier<TodoFilterState> {
  TodoFilterProvider() : super(const TodoFilterState());

  void changeFilter(Filter newFilter){
    state = state.copyWith(filter: newFilter);
  }
}