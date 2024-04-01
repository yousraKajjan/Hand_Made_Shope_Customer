abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadinState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  String error;
  LoginErrorState(this.error);
}

class LoginVisiblePasswordState extends LoginState {}
