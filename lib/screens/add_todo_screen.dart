import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_supabase/models/todo_item_model.dart';
import 'package:todo_supabase/providers/todo_provider.dart';
import 'package:todo_supabase/utils/colors.dart';
import 'package:todo_supabase/widgets/textfield.dart';

class AddTodoScreen extends StatefulWidget {
  final TodoItem? todoItem;

  const AddTodoScreen({super.key, this.todoItem});

  @override
  AddTodoScreenState createState() => AddTodoScreenState();
}

class AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final GlobalKey<AddTodoScreenState> addTodoKey = GlobalKey();
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
    return ChangeNotifierProvider<TodoProvider>(
      create: (_) => TodoProvider(),
      child: Consumer<TodoProvider>(
        builder: (context, provider, child) => Scaffold(
          appBar: AppBar(
            title: widget.todoItem != null
                ? const Text('Edit Todo')
                : const Text('Add New Todo'),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [blueGradientTop, blueGradientBottom],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TodoTextField(
                          label: "Todo title",
                          obscureText: false,
                          inputType: TextInputType.text,
                          icon: Icons.title,
                          controller: _titleController,
                        ),
                        TodoTextField(
                          controller: _descriptionController,
                          label: "Content of Todo",
                          icon: Icons.text_fields,
                          inputType: TextInputType.text,
                          obscureText: false,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (provider.validate(_titleController.text.trim(),
                                _descriptionController.text.trim())) {
                              if (widget.todoItem != null) {
                                // Update existing todo item
                                widget.todoItem!.title =
                                    _titleController.text.trim();
                                widget.todoItem!.content =
                                    _descriptionController.text.trim();
                                await provider.updateTodo(widget.todoItem!);
                              } else {
                                // Add new todo item
                                final todoItem = TodoItem(
                                    title: _titleController.text.trim(),
                                    content: _descriptionController.text.trim(),
                                    status: false);
                                await provider.createTodo(
                                    todoItem.title, todoItem.content);
                              }
                              Navigator.pop(addTodoKey.currentContext!);
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
          ),
        ),
      ),
    );
  }
}
