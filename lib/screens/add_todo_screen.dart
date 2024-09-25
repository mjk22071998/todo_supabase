import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_supabase/models/todo_item_model.dart';
import 'package:todo_supabase/view_models/todo_model.dart';

class AddTodoScreen extends StatefulWidget {
  final TodoItem? todoItem;

  AddTodoScreen({this.todoItem});

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todoItem != null) {
      _titleController.text = widget.todoItem!.title;
      _descriptionController.text = widget.todoItem!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoModel>(
      create: (_) => TodoModel(),
      child: Consumer<TodoModel>(
        builder: (context, provider, child) => Scaffold(
          appBar: AppBar(
            title: widget.todoItem != null
                ? const Text('Edit Todo')
                : const Text('Add New Todo'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (widget.todoItem != null) {
                          // Update existing todo item
                          widget.todoItem!.title = _titleController.text;
                          widget.todoItem!.content =
                              _descriptionController.text;
                          await provider.updateTodo(widget.todoItem!);
                        } else {
                          // Add new todo item
                          final todoItem = TodoItem(
                              title: _titleController.text,
                              content: _descriptionController.text,
                              status: false);
                          await provider.createTodo(
                              todoItem.title, todoItem.content);
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: widget.todoItem != null
                        ? const Text('Update Todo')
                        : const Text('Add Todo'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
