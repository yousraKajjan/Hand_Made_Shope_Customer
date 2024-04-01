import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_namaa/cubit/siginUp/state.dart';
import 'package:project_namaa/cubit/siginUp/util.dart';
import 'package:project_namaa/shared/resources/add_data.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitialState());
  static SignUpCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isobscurePssword = false;
  bool isobscurePsswordConfirm = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  void isvisblePassword() {
    isobscurePssword = !isobscurePssword;
    emit(SignUpVisiblePasswordState());
  }

  void isvisblePasswordCofirm() {
    isobscurePsswordConfirm = !isobscurePsswordConfirm;
    emit(SignUpVisiblePasswordConfirmState());
  }

  Uint8List? image;
  void SelectImage() async {
    Uint8List img = await imagePicker(ImageSource.gallery);
    image = img;
    emit(UploadImageState());
  }

  void saveProfile() async {
    String name = nameController.text;
    String phoneNumber = PhoneNumberController.text;
    String email = emailController.text;
    String resp = await StoreData().saveData(
        name: name, phoneNumber: phoneNumber, email: email, file: image!);
  }

  void sinup(BuildContext context) async {
    emit(SignUpLoadinState());
    try {
      if (formKey.currentState?.validate() ?? false) {
        if (passwordController.text == ConfirmPasswordController.text) {
          UserCredential result = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
          saveProfile();
          print(result);
          emit(SignUpSuccessState());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password isn\'t confirm'),
            ),
          );
        }
      } else {
        emit(SignUpErrorState('Fields Required'));
      }
    } catch (e) {
      emit(
        SignUpErrorState(
          e.toString(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }
}
