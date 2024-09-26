import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_supabase/models/todo_item_model.dart';
import 'package:todo_supabase/screens/add_todo_screen.dart';
import 'package:todo_supabase/providers/todo_provider.dart';
import 'package:todo_supabase/utils/colors.dart';
import 'package:todo_supabase/widgets/todo_list_item.dart';

class HomeScreen extends StatelessWidget {
  String userId;

  HomeScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoProvider>(
      create: (_) => TodoProvider(),
      child: Consumer<TodoProvider>(
        builder: (context, provider, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Todo App'),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [blueGradientTop, blueGradientBottom],
              ),
            ),
            child: FutureBuilder(
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
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddTodoScreen()));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
