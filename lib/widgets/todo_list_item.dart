import 'package:flutter/material.dart';
import 'package:todo_supabase/models/todo_item_model.dart';
import 'package:provider/provider.dart';
import 'package:todo_supabase/screens/add_todo_screen.dart';
import 'package:todo_supabase/view_models/todo_model.dart';

class TodoListItem extends StatelessWidget {
  final TodoItem todo;

  const TodoListItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.content),
      trailing: Checkbox(
        value: todo.status,
        onChanged: (value) {
          context.read<TodoModel>().updateTodo(todo.copyWith(status: value!));
        },
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddTodoScreen(
                      todoItem: todo,
                    )));
      },
      onLongPress: () {
        // Delete todo item
        context.read<TodoModel>().deleteTodo(todo);
      },
    );
  }
}
