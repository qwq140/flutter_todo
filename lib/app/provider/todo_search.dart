import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TodoSearchState extends Equatable{
  final String searchTerm;

  const TodoSearchState({this.searchTerm = ''});

  @override
  List<Object?> get props => throw [searchTerm];

  @override
  bool get stringify => true;

  TodoSearchState copyWith({String? searchTerm}) => TodoSearchState(searchTerm: searchTerm ?? this.searchTerm);
}

class TodoSearchProvider with ChangeNotifier {
  TodoSearchState _state = const TodoSearchState();
  TodoSearchState get state => _state;

  void setSearchTerm(String newSearchTerm){
    _state = _state.copyWith(searchTerm : newSearchTerm);
    notifyListeners();
  }
}