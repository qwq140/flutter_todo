import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';

class TodoSearchState extends Equatable{
  final String searchTerm;

  const TodoSearchState({this.searchTerm = ''});

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  TodoSearchState copyWith({String? searchTerm}) => TodoSearchState(searchTerm: searchTerm ?? this.searchTerm);
}

class TodoSearchProvider extends StateNotifier<TodoSearchState> {
  TodoSearchProvider() : super(const TodoSearchState());

  void setSearchTerm(String newSearchTerm){
    state = state.copyWith(searchTerm : newSearchTerm);
  }
}