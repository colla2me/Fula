import 'dart:async';
import 'package:meta/meta.dart';
import '../models/todo_entity.dart';
import '../services/file_storage.dart';
import '../services/web_client.dart';

abstract class TodosRepository {

  Future<List<TodoEntity>> loadTodos();

  Future saveTodos(List<TodoEntity> todos);
}

class TodosRepositoryImpl implements TodosRepository {
  final FileStorage fileStorage;
  final WebClient webClient;

  const TodosRepositoryImpl({
    @required this.fileStorage,
    this.webClient = const WebClient()
  });

  @override
  Future<List<TodoEntity>> loadTodos() async {
    try {
      return await fileStorage.loadTodos();
    } catch (e) {
      final todos =await webClient.fetchTodos();
      fileStorage.saveTodos(todos);
      return todos;
    }
  }

  @override
  Future saveTodos(List<TodoEntity> todos) {
    return Future.wait<dynamic>([
      fileStorage.saveTodos(todos),
      webClient.postTodos(todos)
    ]);
  }
}
