import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app_sochial/layout/Home_Layout/screens/chats/chats.dart';
import 'package:my_app_sochial/layout/Home_Layout/screens/feeds/feeds.dart';
import 'package:my_app_sochial/models/usersModel.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/state.dart';
import 'package:my_app_sochial/shared/Cubit/LoginCubit/states.dart';

import '../../../Components/components.dart';
import '../../../layout/Home_Layout/screens/notifications/notifications.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class socialCubit extends Cubit<socialStates> {
  socialCubit() : super(socialInitialState());
  static socialCubit get(context) => BlocProvider.of(context);
  TextEditingController dateController = TextEditingController();

  socialUsersModel? model;
  void getUserData() {
    emit(socialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      model = socialUsersModel.fromJson(value.data()!);
      emit(socialGetUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(socialGetUserErorrState(onError));
    });
  }

  int currentIndex = 0;
  List<Widget> homeScreen = [
    Feeds(),
    Notifications(),
  ];
  List<String?> title = ["الرئيسية", "الاشعارات"];
  void changeBottomNav(int? index) {
    currentIndex = index!;
    emit(socialChangebuttomNavState());
  }

  DateTime? selectedDate;
  Future SelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime.now());
    if (picked != null || picked != selectedDate) {}
    {
      selectedDate = picked;
      dateController.value = TextEditingValue(
          text: "${picked!.day},${picked.month},${picked.year}");
      emit(socialChangeDateState());
    }
  }

  final picker = ImagePicker();
  File? profileimage;
  Future<void> getProfileImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileimage = File(image.path);

      emit(socialProfileImagePickedSuccessState());
    } else {
      emit(socialProfileImagePickedErorrState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      coverImage = File(image.path);

      emit(socialProfileCoverPickedSuccessState());
    } else {
      emit(socialProfileCoverPickedErorrState());
    }
  }

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${uId}/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
      }).catchError((onError) {});
    }).catchError((onError) {});
  }
}
