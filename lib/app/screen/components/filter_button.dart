import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/models/todo_model.dart';
import 'package:todo/app/provider/todo_filter.dart';

class FilterButton extends StatelessWidget {
  final Filter filter;
  late final String text;

  FilterButton({Key? key, required this.filter}) : super(key: key) {
    switch (filter) {
      case Filter.all:
        text = 'All';
        break;
      case Filter.active:
        text = 'Active';
        break;
      case Filter.completed:
        text = 'Completed';
        break;
      default:
        text = '';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentFilter = context.watch<TodoFilterState>().filter;
    final textColor = currentFilter == filter ? Colors.blue : Colors.grey;
    return TextButton(
      onPressed: () {
        context.read<TodoFilterProvider>().changeFilter(filter);
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 18, color: textColor),
      ),
    );
  }
}
