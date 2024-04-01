abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadinState extends SignUpState {}

class SignUpSuccessState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  String error;
  SignUpErrorState(this.error);
}

class SignUpVisiblePasswordState extends SignUpState {}

class SignUpVisiblePasswordConfirmState extends SignUpState {}

class UploadImageState extends SignUpState {}
