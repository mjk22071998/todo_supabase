import 'package:flutter/material.dart';
import 'package:todo_supabase/models/todo_item_model.dart';
import 'package:provider/provider.dart';
import 'package:todo_supabase/screens/add_todo_screen.dart';
import 'package:todo_supabase/providers/todo_provider.dart';

class TodoListItem extends StatelessWidget {
  final TodoItem todo;

  const TodoListItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoScreen(
                todoItem: todo,
              ),
            ),
          );
        },
        onLongPress: () {
          // Delete todo item
          context.read<TodoProvider>().deleteTodo(todo);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(todo.content),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Switch(
                    value: todo.status,
                    onChanged: (value) {
                      context
                          .read<TodoProvider>()
                          .updateTodo(todo.copyWith(status: value));
                    },
                  ),
                  const Text(
                    'Long press to delete',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}