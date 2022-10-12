import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/provider/todo_search.dart';
import 'package:todo/app/utils/debounce.dart';

class SearchWidget extends StatelessWidget {
  final debounce = Debounce(milliseconds: 1000);

  SearchWidget({Key? key}) : super(key: key);

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
        debounce.run(() {
          context.read<TodoSearchProvider>().setSearchTerm(value);
        });
      },
    );
  }
}
