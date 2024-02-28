part of 'un_auth_todo_cubit.dart';

@immutable
abstract class UnAuthTodoState {}

class UnAuthTodoInitial extends UnAuthTodoState {}
class UnAuthTodoChangeBottomNavBarState extends UnAuthTodoState {}
class UnAuthTodoChangeTabBarState extends UnAuthTodoState {}
class UnAuthTodoCreateDatabaseState extends UnAuthTodoState {}
class UnAuthTodoInsertToDatabaseState extends UnAuthTodoState {}
class UnAuthTodoGetFromDatabaseState extends UnAuthTodoState {}
class UnAuthTodoGetFromDatabaseLoadingState extends UnAuthTodoState {}
class UnAuthTodoUpdateDatabaseState extends UnAuthTodoState {}
class UnAuthTodoDeleteFromDatabaseState extends UnAuthTodoState {}