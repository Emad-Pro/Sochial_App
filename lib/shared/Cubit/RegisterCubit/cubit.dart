// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_sochial/shared/Cubit/RegisterCubit/states.dart';

class SochialRegisterCubit extends Cubit<SochialRegisterState> {
  SochialRegisterCubit() : super(SochialRegisterInitialState());
  static SochialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(SochialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email.toString());
      print(value.user!.uid.toString());
      emit(SochialRegisterSuccessState());
    }).catchError((onError) {
      emit(SochialRegisterErorrState(onError));
    });
  }

  bool PasswordVisibility = true;
  IconData suffixicon = Icons.visibility;
  Color? colorbisibility = Colors.purple[900];
  void ispassword() {
    PasswordVisibility = !PasswordVisibility;
    if (PasswordVisibility == true) {
      suffixicon = Icons.visibility_off_rounded;
      colorbisibility = Colors.purple[900];
    } else {
      suffixicon = Icons.visibility;
      colorbisibility = Colors.black;
    }

    emit(SochialRegisterChangeOserctorAndIconState());
  }
}
