import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';
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
class FilteredTodoListProvider extends StateNotifier<FilteredTodoListState>
    with LocatorMixin {
  FilteredTodoListProvider() : super(FilteredTodoListState());

  @override
  void update(Locator watch) {
    final Filter filter = watch<TodoFilterState>().filter;
    final String searchTerm = watch<TodoSearchState>().searchTerm;
    final List<TodoModel> todoList = watch<TodoListState>().todoList;

    List<TodoModel> _filteredTodoList;

    switch (filter) {
      case Filter.active:
        _filteredTodoList = todoList.where((e) => !e.isDone).toList();
        break;
      case Filter.completed:
        _filteredTodoList = todoList.where((e) => e.isDone).toList();
        break;
      case Filter.all:
      default:
        _filteredTodoList = todoList;
    }

    if (searchTerm.isNotEmpty) {
      _filteredTodoList = _filteredTodoList
          .where((e) => e.content.contains(searchTerm))
          .toList();
    }
    state = state.copyWith(filteredTodoList: _filteredTodoList);
    super.update(watch);
  }

// FilteredTodoListState get state {
//   List<TodoModel> _filteredTodoList;
//
//   switch (todoFilter.state.filter) {
//     case Filter.active:
//       _filteredTodoList =
//           todoList.state.todoList.where((e) => !e.isDone).toList();
//       break;
//     case Filter.completed:
//       _filteredTodoList =
//           todoList.state.todoList.where((e) => e.isDone).toList();
//       break;
//     case Filter.all:
//     default:
//       _filteredTodoList = todoList.state.todoList;
//   }
//
//   if (todoSearch.state.searchTerm.isNotEmpty) {
//     _filteredTodoList = _filteredTodoList
//         .where((e) => e.content.contains(todoSearch.state.searchTerm))
//         .toList();
//   }
//
//   return FilteredTodoListState(filteredTodoList: _filteredTodoList);
// }
}
