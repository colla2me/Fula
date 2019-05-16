import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/repository.dart';
import '../models/todo.dart';

enum VisibilityFilter { all, active, complete }

class TodoListModel extends Model {
  final TodosRepository repository;

  VisibilityFilter _activeFilter;

  List<Todo> _todos = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  VisibilityFilter get activeFilter => _activeFilter;

  set activeFilter(VisibilityFilter filter) {
    _activeFilter = filter;
    notifyListeners();
  }

  List<Todo> get todos => _todos;

  TodoListModel({@required this.repository, VisibilityFilter activeFilter}) : this._activeFilter = activeFilter ?? VisibilityFilter.all;

  static TodoListModel of(BuildContext context) => ScopedModel.of<TodoListModel>(context);

  @override
  void addListener(listener) {
    super.addListener(listener);
    loadTodos();
  }

  Future loadTodos() {
    _isLoading = true;
    notifyListeners();

    return repository.loadTodos().then((loadedTodos) {
      _todos =loadedTodos.map(Todo.fromEntity).toList();
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      _todos = [];
      notifyListeners();
    });
  }

  List<Todo> get filteredTodos => _todos.where((todo) {
    if (_activeFilter == VisibilityFilter.all) {
      return true;
    } else if (_activeFilter ==VisibilityFilter.active) {
      return !todo.complete;
    } else if (_activeFilter ==VisibilityFilter.complete) {
      return todo.complete;
    }
  }).toList();

  void clearCompleted() {
    _todos.removeWhere((todo) => todo.complete);
    notifyListeners();
  }

  void toggleAll() {
    var allComplete = todos.every((todo) => todo.complete);
    _todos = _todos.map((todo) => todo.copy(complete: !allComplete)).toList();
    notifyListeners();
    _uploadItems();
  }

  void updateTodo(Todo todo) {
    assert(todo !=null);
    assert(todo.id !=null);
    var oldTodo = _todos.firstWhere((it) => it.id == todo.id);
    var replaceIndex =_todos.indexOf(oldTodo);
    _todos.replaceRange(replaceIndex, replaceIndex + 1, [todo]);
    notifyListeners();
    _uploadItems();
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
    _uploadItems();
  }

  void removeTodo(Todo todo) {
    _todos.removeWhere((it) => it.id ==todo.id);
    notifyListeners();
    _uploadItems();
  }

  void _uploadItems() {
    repository.saveTodos(todos.map((it) => it.toEntity()).toList());
  }

  Todo todoById(String id) {
    return _todos.firstWhere((it) => it.id == id, orElse: () => null);
  }
}
