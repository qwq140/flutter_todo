import 'package:flutter/material.dart';
import 'package:todo/app/screen/components/create_todo.dart';
import 'package:todo/app/screen/components/filter_tab.dart';
import 'package:todo/app/screen/components/search_widget.dart';
import 'package:todo/app/screen/components/show_todo.dart';
import 'package:todo/app/screen/components/todo_header.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                const TodoHeader(),
                const CreateTodo(),
                const SizedBox(height: 20,),
                SearchWidget(),
                const SizedBox(height: 10,),
                const FilterTab(),
                const ShowTodo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}