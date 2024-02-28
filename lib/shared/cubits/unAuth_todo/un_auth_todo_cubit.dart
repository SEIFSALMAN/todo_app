import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'un_auth_todo_state.dart';

class UnAuthTodoCubit extends Cubit<UnAuthTodoState> {
  UnAuthTodoCubit() : super(UnAuthTodoInitial());


  static UnAuthTodoCubit get(context) => BlocProvider.of(context);


  late Database database;
  List<Map> todoTasks = [];
  List<Map> refunds = [];



  void createDatabase() {
    openDatabase('toDo.db', version: 1,
      onCreate: (database, version) {
        print('Database Created!');
        database.execute(
            'CREATE TABLE toDo(id INTEGER PRIMARY KEY, titleTask TEXT, description TEXT, category TEXT, date TEXT, time TEXT, status TEXT)').then((value) {
          print('ToDo Table Created!');
        }).catchError((error) {
          print('Error on creating Table !');
        });

      }, onOpen: (database) {
        getTodoTasksFromDatabase(database);
        print('Database Opened!');
      },
    ).then((value) {
      database = value;
      emit(UnAuthTodoCreateDatabaseState());});
  }

  insertToDoTasksToDatabase({
    required String titleTask,
    required String description,
    required String category,
    required String date,
    required String time
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO toDo(titleTask , description , category , date , time , status) VALUES("$titleTask","$description","$category","$date","$time","false")')
          .then((value) {
        print('$value Inserted Successfully in Tasks!');
        emit(UnAuthTodoInsertToDatabaseState());
        getTodoTasksFromDatabase(database);
      }).catchError((error) {
        print('Error : ${error.toString()}');
      });
    });
  }



  void getTodoTasksFromDatabase(database)
  {
    todoTasks = [];
    print('in getTodoTasksFromDatabase');
    // emit(UnAuthTodoGetFromDatabaseLoadingState());
    database.rawQuery('SELECT * FROM toDo').then((value) {

      value.forEach((element) {
        if(element['status'] == 'false'){todoTasks.add(element);}
        else if(element['status'] == 'done'){todoTasks.add(element);}
      });
      print('in getTodoTasksFromDatabase');
      emit(UnAuthTodoGetFromDatabaseState());
    });
  }


  void getDoneFromDatabase(database)
  {
    // todoTasks = [];
    print('in getDoneFromDatabase');
    // emit(UnAuthTodoGetFromDatabaseLoadingState());
    database.rawQuery('SELECT * FROM toDo').then((value) {
      value.forEach((element) {
        if(element['status'] == 'done'){todoTasks.add(element);}
      });

      print('in getDoneFromDatabase');
      emit(UnAuthTodoGetFromDatabaseState());
    });
  }


  void updateToDoTasksStatusData({
    required String status,
    required int id,
  }) async
  {
    database.rawUpdate(
      'UPDATE toDo SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      print('Updated From Tasks');
      getTodoTasksFromDatabase(database);
      emit(UnAuthTodoUpdateDatabaseState());
    });

  }


  void deleteToDoTasksData({
    required int id,
  }) async
  {
    database.rawDelete(
        'DELETE FROM toDo WHERE id = ?', [id])
        .then((value) {
      print('Deleted From Tasks');
      getTodoTasksFromDatabase(database);
      emit(UnAuthTodoDeleteFromDatabaseState());
    });

  }


}
