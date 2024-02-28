part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterErrorState extends RegisterState {

  final String error;
  RegisterErrorState(this.error);

}
class RegisterWithPhoneLoadingState extends RegisterState {}
class RegisterWithPhoneSuccessState extends RegisterState {}
class RegisterWithPhoneErrorState extends RegisterState {

  final String error;
  RegisterWithPhoneErrorState(this.error);

}
class CreateUserSuccessState extends RegisterState {}
class CreateUserErrorState extends RegisterState {

  final String error;
  CreateUserErrorState(this.error);

}
class RegisterChangePasswordVisibilityState extends RegisterState {}
