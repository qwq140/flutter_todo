import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/provider/providers.dart';
import 'package:todo/app/screen/list_page.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<TodoFilterProvider, TodoFilterState>(create: (context)=> TodoFilterProvider()),
        StateNotifierProvider<TodoSearchProvider, TodoSearchState>(create: (context)=> TodoSearchProvider()),
        StateNotifierProvider<TodoListProvider, TodoListState>(create: (context)=> TodoListProvider()),
        StateNotifierProvider<ActiveTodoCountProvider, ActiveTodoCountState>(create: (context)=> ActiveTodoCountProvider()),
        StateNotifierProvider<FilteredTodoListProvider, FilteredTodoListState>(create: (context)=> FilteredTodoListProvider()),
      ],
      child: MaterialApp(
        title: 'TODO',
        debugShowCheckedModeBanner: false,
        home: ListPage(),
      ),
    );
  }
}
