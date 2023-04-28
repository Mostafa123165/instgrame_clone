
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String message ;
  LoginErrorState({required this.message});
}

class LoginLoadingState extends LoginState {}

class ChangeStatePasswordState extends LoginState {}
