import 'dart:async';
import 'dart:convert';
import 'dart:io';
import '../models/todo_entity.dart';

class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.tag,
    this.getDirectory
  );

  Future<List<TodoEntity>> loadTodos() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    return (json['todos'] as List).map<TodoEntity>((todo) => TodoEntity.fromJson(todo)).toList();
  }

  Future<File> saveTodos(List<TodoEntity> todos) async {
    final file = await _getLocalFile();
    return file.writeAsString(JsonEncoder().convert({
      'todos': todos.map((todo) => todo.toJson()).toList()
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();
    return File('${dir.path}/TodoAppStorage__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();
    return file.delete();
  }
}
