import 'package:flutter/material.dart';
import 'package:todo_lists/todo.dart';
import 'package:todo_lists/new_todo_dialog.dart';
import 'package:todo_lists/todo_list.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  _toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }
  _addTodo() async {
    final todo = await showDialog<Todo>(
      context: context,
      builder: (BuildContext context) {
        return NewTodoDialog();
      }
    );
    if (todo != null) {
      setState(() {
        todos.add(todo);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          final todo = todos[index];
          return CheckboxListTile(
            value: todo.isDone,
            title: Text(todo.title),
            onChanged: (bool? isChecked) {
              _toggleTodo(todo, isChecked ?? !todo.isDone);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}
