import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_supabase/models/todo_model.dart';
import 'package:todo_supabase/screens/add_todo_screen.dart';
import 'package:todo_supabase/providers/todo_provider.dart';
import 'package:todo_supabase/screens/login_screen.dart';
import 'package:todo_supabase/session/session_manager.dart';
import 'package:todo_supabase/utils/colors.dart';
import 'package:todo_supabase/utils/constants.dart';
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
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await SessionManager.logoutUser();
                  await supabase.auth.signOut();
                  if (context.mounted) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  }
                },
              ),
            ],
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
                  return const Center(
                      child: Text('No Notes found for the user'));
                } else {
                  List<TodoModel> todos = snapshot.data!;
                  if (todos.isNotEmpty) {
                    return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return TodoListItem(
                          todo: todos[index],
                          index: index,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("No Todo Found"),
                        ),
                      ),
                    );
                  }
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
