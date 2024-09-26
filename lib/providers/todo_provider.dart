import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/models/todo_item_model.dart';
import 'package:intl/intl.dart';
import 'package:todo_supabase/models/user_model.dart';
import 'package:todo_supabase/session/session_manager.dart';
import 'package:todo_supabase/utils/constants.dart';

class TodoProvider with ChangeNotifier {
  List<TodoItem> _todos = [];

  List<TodoItem> get todos => _todos;

  Future<List<TodoItem>> fetchTodos(String userId) async {
    final response = await supabase
        .from('notes')
        .select('id, title, content, status, created_at')
        .eq('uid', userId);

    _todos = response.map((item) => TodoItem.fromMap(item)).toList();
    notifyListeners();
    return _todos;
  }

  Future<void> createTodo(String title, String description) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss EEE d MMM').format(now);
    try {
      UserModel user = await SessionManager.getUser();
      await supabase.from('notes').insert({
        'title': title,
        'content': description,
        'status': false,
        "created_at": formattedDate,
        "uid": user.id,
      });
    } on PostgrestException catch (e) {
      Fluttertoast.showToast(msg: "No Todo exist in the database for user");
      log(e.toString());
    }
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

  Future<void> updateTodo(TodoItem todo) async {
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
    notifyListeners();
  }

  Future<void> deleteTodo(TodoItem todo) async {
    try {
      await supabase.from('notes').delete().eq('id', todo.id!);
    } on PostgrestException catch (e) {
      Fluttertoast.showToast(msg: "Failed to delete todo");
      log(e.toString());
    }
    notifyListeners();
  }
}
