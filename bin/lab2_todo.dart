import "package:lab2_todo/todo.dart";
import "dart:io";
import "package:ansicolor/ansicolor.dart";

final AnsiPen greenPen = AnsiPen()..green();
final AnsiPen redPen = AnsiPen()..red();
final AnsiPen bluePen = AnsiPen()..blue();
final AnsiPen yellowPen = AnsiPen()..yellow();

void main(){
  List<Todo> todos = [];
  printmenu();
  while(true){
    stdout.write("> ");
    String? input = stdin.readLineSync();
    if(input == null) continue;
    String command = input.trim().toLowerCase();
    if(command.isEmpty) continue;
    switch(command){
      case "add":
        addTodo(todos);
        break;
      case "list":
        listTodos(todos);
        break;
      case "done":
        comletetodo(todos);
        break;
      case "delete":
        deleteTodo(todos);
        break;
      case "exit":
        print(bluePen("Выход из программы"));
        return;
      default:
        print(yellowPen("Неизвестная команда"));
    }
  }
}
void printmenu(){
  print("");
  print(yellowPen("Todo лист"));
  print("add    - Добавить задачу");
  print("list   - Показать список задач");
  print("done   - Отметить задачу как выполненную");
  print("delete - Удалить задачу");
  print("exit   - Выйти из программы");
}

void addTodo(List<Todo> todos){
  stdout.write("Введите название задачи: ");
  String? title = stdin.readLineSync();
  if(title == null || title.isEmpty){
    print(redPen("Название задачи не может быть пустым"));
    return;
  }
  todos.add(Todo(title: title.trim()));
  print(greenPen("Задача добавлена"));
}
void listTodos(List<Todo> todos){
  if(todos.isEmpty){
    print(bluePen("Список задач пуст"));
    return;
  }
  for(Todo todo in todos){
    print(todo);
  }
}
void comletetodo(List<Todo> todos){
  stdout.write("Введите id задачи: ");
  String? input = stdin.readLineSync();
  if(input == null ) return;
  int? id = int.tryParse(input.trim());
  if(id == null){
    print(redPen("Введите число"));
    return;
  }
  for(var todo in todos){
    if(todo.id == id){
      todo.complete();
      print(greenPen("Задача выполнена"));
      return;
    }
  }
  print(redPen("Задача с таким id не найдена"));
}
void deleteTodo(List<Todo> todos){
  stdout.write("Введите id задачи: ");
  String? input = stdin.readLineSync();
  if(input == null ) return;
  int? id = int.tryParse(input.trim());
  if(id == null){
    print(redPen("Введите число"));
    return;
  }
  for(int i = 0; i < todos.length; i++){
    if(todos[i].id == id){
      todos.removeAt(i);
      print(yellowPen("задача удалена"));
      return;
    }
  }
  print(redPen("Задача с таким id не найдена"));
}