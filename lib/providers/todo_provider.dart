import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/models/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:todo_supabase/models/user_model.dart';
import 'package:todo_supabase/session/session_manager.dart';
import 'package:todo_supabase/utils/constants.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> _todos = [];

  List<TodoModel> get todos => _todos;

  Future<List<TodoModel>> fetchTodos(String userId) async {
    final response = await supabase
        .from('notes')
        .select('id, title, content, status, created_at')
        .eq('uid', userId);

    _todos = response.map((item) => TodoModel.fromMap(item)).toList();
    _todos.sort(
      (a, b) {
        return a.created_at!.compareTo(b.created_at!);
      },
    );
    return _todos;
  }

  Future<void> createTodo(String title, String description) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);
    UserModel user = await SessionManager.getUser();
    try {
      await supabase.from('notes').insert({
        'title': title,
        'content': description,
        'status': false,
        "created_at": formattedDate,
        "uid": user.id,
      });
    } on PostgrestException catch (e) {
      Fluttertoast.showToast(msg: "Todo creation failed");
      log(e.toString());
    }
    _todos = await fetchTodos(user.id);
    notifyListeners();
  }

  bool validate(String title, String description) {
    if (title.isEmpty) {
      Fluttertoast.showToast(msg: "Enter title");
      return false;
    } else if (description.isEmpty) {
      Fluttertoast.showToast(msg: "Enter description");
      return false;
    } else {
      return true;
    }
  }

  Future<void> updateTodo(TodoModel todo, int index) async {
    try {
      await supabase.from('notes').update({
        'title': todo.title,
        'content': todo.content,
        'status': todo.status
      }).eq('id', todo.id!);
    } on PostgrestException catch (e) {
      Fluttertoast.showToast(msg: "Failed to update todo");
      log(e.toString());
    }
    final user = await SessionManager.getUser();
    fetchTodos(user.id);
    notifyListeners();
  }

  Future<void> deleteTodo(TodoModel todo, int index) async {
    try {
      await supabase.from('notes').delete().eq('id', todo.id!);
    } on PostgrestException catch (e) {
      Fluttertoast.showToast(msg: "Failed to delete todo");
      log(e.toString());
    }
    _todos.removeAt(index);
    notifyListeners();
  }
}
