import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/provider/providers.dart';
import 'package:todo/app/screen/components/todo_item.dart';

class ShowTodo extends StatelessWidget {
  const ShowTodo({Key? key}) : super(key: key);

  Widget showBackGround(int direction) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoList =
        context.watch<FilteredTodoListState>().filteredTodoList;
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(todoList[index].id),
          background: showBackGround(0), // child를 오른쪽으로 드래그할 때 보인다.
          secondaryBackground: showBackGround(1), // child를 왼쪽으로 드래그할 때 보인다.
          onDismissed: (_) {
            context.read<TodoListProvider>().remove(id: todoList[index].id);
          },
          confirmDismiss: (_) {
            return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('Do you really want to delete'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
          child: TodoItem(todo: todoList[index]),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
      ),
      itemCount: todoList.length,
    );
  }
}
