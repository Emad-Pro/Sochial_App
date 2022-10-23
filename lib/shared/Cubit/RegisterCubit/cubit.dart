// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_sochial/shared/Cubit/RegisterCubit/states.dart';

import '../../../models/usersModel.dart';

class socialRegisterCubit extends Cubit<socialRegisterState> {
  socialRegisterCubit() : super(socialRegisterInitialState());
  static socialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(socialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email.toString());
      print(value.user!.uid.toString());
      userCreate(
          email: email,
          name: name,
          phone: phone,
          uId: value.user!.uid.toString());
    }).catchError((onError) {
      emit(socialRegisterErorrState(onError));
      print(onError.toString());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    String? date,
    String? education,
    String? relationship,
    required String uId,
  }) {
    socialUsersModel? model = socialUsersModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
      image:
          'https://img.freepik.com/free-photo/studio-portrait-bearded-man-posing-beige-background-looking-into-camera-with-broad-smile-his-face_295783-16582.jpg?w=740&t=st=1666104228~exp=1666104828~hmac=a3d773d1949d9798115cf824499df4eba19b1915539ed797673cdd7adfa51775',
      bio: 'write Your Bio ...',
      education: education,
      relationship: email,
      date: date!,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(socialCreateUserSuccessState());
    }).catchError((onError) {
      emit(socialCreateUserErorrState(onError));
      print(onError.toString());
    });
  }

  bool PasswordVisibility = true;
  IconData? suffixicon = Icons.visibility_off_rounded;
  void ispassword() {
    PasswordVisibility = !PasswordVisibility;
    if (PasswordVisibility == true) {
      suffixicon = Icons.visibility_off_rounded;
    } else {
      suffixicon = Icons.visibility;
    }

    emit(socialRegisterChangeOserctorAndIconState());
  }
}
