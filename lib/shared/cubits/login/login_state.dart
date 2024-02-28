part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {
  final String uId;

  LoginSuccessState(this.uId);
}
class LoginErrorState extends LoginState {

  final String error;
  LoginErrorState(this.error);

}
class LoginGoogleSuccessState extends LoginState {
  final String uId;
  LoginGoogleSuccessState(this.uId);
}
class LoginGoogleErrorState extends LoginState {
  final String error;
  LoginGoogleErrorState(this.error);
}
class LoginFacebookSuccessState extends LoginState {
  final String uId;
  LoginFacebookSuccessState(this.uId);
}
class LoginFacebookErrorState extends LoginState {
  final String error;
  LoginFacebookErrorState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginState {}
