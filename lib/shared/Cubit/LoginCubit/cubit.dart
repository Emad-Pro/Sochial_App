// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_sochial/shared/Cubit/LoginCubit/states.dart';

class SochialLoginCubit extends Cubit<SochialLoginState> {
  SochialLoginCubit() : super(SochialLoginInitialState());
  static SochialLoginCubit get(context) => BlocProvider.of(context);

  bool? isConnected;

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(SochialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SochialLoginSuccessState());
    }).catchError((onError) {
      emit(SochialLoginErorrState(onError.toString()));
    });
  }

  bool PasswordVisibility = true;
  IconData suffixicon = Icons.visibility;
  Color? colorbisibility = Colors.white;
  void ispassword() {
    PasswordVisibility = !PasswordVisibility;
    if (PasswordVisibility == true) {
      suffixicon = Icons.visibility_off_rounded;
      colorbisibility = Colors.white;
    } else {
      suffixicon = Icons.visibility;
      colorbisibility = Colors.white;
    }

    emit(SochialLoginChangeOserctorAndIconState());
  }
}
