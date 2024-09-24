import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/models/todo_item.dart';
import 'package:intl/intl.dart';

class TodoModel with ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<TodoItem> _todos = [];

  List<TodoItem> get todos => _todos;

  Future<List<TodoItem>> fetchTodos(String userId) async {
    final response = await _supabase
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
      await _supabase.from('notes').insert({
        'title': title,
        'content': description,
        'status': false,
        "created_at": formattedDate
      });
    } on PostgrestException catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateTodo(TodoItem todo) async {
    try {
      await _supabase.from('notes').update({
        'title': todo.title,
        'content': todo.description,
        'status': todo.isCompleted
      }).eq('id', todo.id!);
    } on PostgrestException catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteTodo(TodoItem todo) async {
    try {
      await _supabase.from('notes').delete().eq('id', todo.id!);
    } on PostgrestException catch (e) {
      log(e.toString());
    }
  }
}
/*
class TodoModel with ChangeNotifier {
  SupabaseClient _supabase = Supabase.instance.client;
  List<TodoItem> _todos = [];

  List<TodoItem> get todos => _todos;

  Future<List<TodoItem>> fetchTodos(String userId) async {
    final response = await _supabase
        .from('todos')
        .select('id, title, description, is_completed')
        .eq('user_id', userId)
        .execute();
    _todos = response.data.map((item) => TodoItem.fromMap(item)).toList();
    notifyListeners();
    return _todos;
  }

  Future<void> createTodo(String title, String description, String userId) async {
    await _supabase
        .from('todos')
        .insert({'title': title, 'description': description, 'user_id': userId})
        .execute();
    await fetchTodos(userId);
  }

  Future<void> updateTodo(TodoItem todo) async {
    await _supabase
        .from('todos')
        .update({'title': todo.title, 'description': todo.description, 'is_completed': todo.isCompleted})
        .eq('id', todo.id)
        .eq('user_id', todo.userId)
        .execute();
    await fetchTodos(todo.userId);
  }

  Future<void> deleteTodo(TodoItem todo) async {
    await _supabase
        .from('todos')
        .delete()
        .eq('id', todo.id)
        .eq('user_id', todo.userId)
        .execute();
    await fetchTodos(todo.userId);
  }
}
*/
