import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/models/todo_model.dart';
import 'package:todo/app/provider/todo_list.dart';

class TodoItem extends StatefulWidget {
  final TodoModel todo;

  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool error = false;
            controller.text = widget.todo.content;

            // dialog 는 현재 위치에 스코프 된게 아니다. 즉 TodoItem 위젯의 자식이 아니다.
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text('Edit todo'),
                  content: TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: error ? 'Value cannot be empty' : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState((){
                          error = controller.text.trim().isEmpty;
                          if(!error){
                            context.read<TodoListProvider>().updateContent(id : widget.todo.id, content : controller.text);
                            Navigator.pop(context);
                          }
                        });
                      },
                      child: const Text('EDIT'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      leading: Checkbox(
        value: widget.todo.isDone,
        onChanged: (value) {
          context.read<TodoListProvider>().toggle(id: widget.todo.id);
        },
      ),
      title: Text(widget.todo.content),
    );
  }
}
