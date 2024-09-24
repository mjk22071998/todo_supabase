import 'package:flutter/material.dart';
import 'package:todo_supabase/models/todo_item.dart';
import 'package:provider/provider.dart';
import 'package:todo_supabase/view_models/todo_model.dart';

class TodoListItem extends StatelessWidget {
  final TodoItem todo;

  const TodoListItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.description),
      trailing: Checkbox(
        value: todo.isCompleted,
        onChanged: (value) {
          context
              .read<TodoModel>()
              .updateTodo(todo.copyWith(isCompleted: value!));
        },
      ),
      onLongPress: () {
        // Delete todo item
        context.read<TodoModel>().deleteTodo(todo);
      },
    );
  }
}
