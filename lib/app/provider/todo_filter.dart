import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

class TodoFilterProvider with ChangeNotifier {
  TodoFilterState _state = const TodoFilterState();
  TodoFilterState get state => _state;

  void changeFilter(Filter newFilter){
    _state = _state.copyWith(filter: newFilter);
    notifyListeners();
  }
}