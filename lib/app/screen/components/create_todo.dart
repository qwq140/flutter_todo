import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/provider/todo_list.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {

  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'What to do?'),
      onSubmitted: (value) {
        if(value.trim().isEmpty) return;
        context.read<TodoListProvider>().addTodo(value);
        controller.clear();
      },
    );
  }
}
