import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_supabase/models/todo_item.dart';
import 'package:todo_supabase/screens/add_todo_screen.dart';
import 'package:todo_supabase/view_models/todo_model.dart';
import 'package:todo_supabase/widgets/todo_list_item.dart';

class HomeScreen extends StatelessWidget {
  String userId;

  HomeScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoModel>(
      create: (_) => TodoModel(),
      child: Consumer<TodoModel>(
        builder: (context, provider, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Todo App'),
          ),
          body: FutureBuilder(
            future: provider.fetchTodos(userId),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTodoScreen()));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
