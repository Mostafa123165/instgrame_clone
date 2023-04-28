
abstract class RegisterState {}

class RegisterBlocInitial extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String message ;
  RegisterErrorState({required this.message});
}

class RegisterLoadingState extends RegisterState {}

class ChangeStatePasswordState extends RegisterState {}
