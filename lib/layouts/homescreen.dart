import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_supabase/models/todo_item.dart';
import 'package:todo_supabase/view_models/todo_model.dart';
import 'package:todo_supabase/widgets/todo_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: FutureBuilder(
        future: context.read<TodoModel>().fetchTodos(""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<TodoItem> todos = snapshot.data!;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return TodoListItem(todo: todos[index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create todo screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}