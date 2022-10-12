import 'package:flutter/material.dart';
import 'package:todo/app/models/todo_model.dart';
import 'package:todo/app/screen/components/filter_button.dart';

class FilterTab extends StatelessWidget {
  const FilterTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: FilterButton(filter: Filter.all)),
        Expanded(child: FilterButton(filter: Filter.active)),
        Expanded(child: FilterButton(filter: Filter.completed)),
      ],
    );
  }
}
