import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/provider/todo_search.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'search todo',
        border: InputBorder.none,
        filled: true,
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (value) {
        context.read<TodoSearchProvider>().setSearchTerm(value);
      },
    );
  }
}
