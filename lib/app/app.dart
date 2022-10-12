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
        ChangeNotifierProxyProvider<TodoListProvider, ActiveTodoCountProvider>(
          create: (context) => ActiveTodoCountProvider(initActiveTodoCount : context.read<TodoListProvider>().state.todoList.length),
          update: (context, TodoListProvider todoList,
              ActiveTodoCountProvider? activeTodoCount) =>
          activeTodoCount!
            ..update(todoList),),
        ChangeNotifierProxyProvider3<TodoFilterProvider,
            TodoSearchProvider,
            TodoListProvider,
            FilteredTodoListProvider>(
          create: (context) => FilteredTodoListProvider(initFilteredTodoList: context.read<TodoListProvider>().state.todoList),
          update: (context, TodoFilterProvider todoFilter,
              TodoSearchProvider todoSearch, TodoListProvider todoList,
              FilteredTodoListProvider? filteredTodoList) => filteredTodoList!..update(todoFilter: todoFilter, todoSearch: todoSearch, todoList: todoList),),

      ],
      child: MaterialApp(
        title: 'TODO',
        debugShowCheckedModeBanner: false,
        home: ListPage(),
      ),
    );
  }
}
