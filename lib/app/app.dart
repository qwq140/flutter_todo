import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/provider/providers.dart';
import 'package:todo/app/screen/list_page.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilterProvider>(
            create: (context) => TodoFilterProvider()),
        ChangeNotifierProvider<TodoSearchProvider>(
            create: (context) => TodoSearchProvider()),
        ChangeNotifierProvider<TodoListProvider>(
            create: (context) => TodoListProvider()),
        ProxyProvider<TodoListProvider, ActiveTodoCountProvider>(
          update: (context, TodoListProvider todoList, _) => ActiveTodoCountProvider(todoList: todoList)),
        ProxyProvider3<TodoFilterProvider,
            TodoSearchProvider,
            TodoListProvider,
            FilteredTodoListProvider>(
          update: (context, TodoFilterProvider todoFilter,
              TodoSearchProvider todoSearch, TodoListProvider todoList, _) => FilteredTodoListProvider(todoFilter: todoFilter, todoSearch: todoSearch, todoList: todoList),),

      ],
      child: MaterialApp(
        title: 'TODO',
        debugShowCheckedModeBanner: false,
        home: ListPage(),
      ),
    );
  }
}
