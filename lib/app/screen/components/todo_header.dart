import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/provider/active_todo_count.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('TODO', style: TextStyle(fontSize: 40),),
        Text('${context.watch<ActiveTodoCountProvider>().state.activeTodoCount} items left', style: TextStyle(fontSize: 20, color: Colors.redAccent),),
      ],
    );
  }
}
