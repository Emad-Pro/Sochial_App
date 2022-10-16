import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_sochial/layout/Home_Layout/screens/chats/chats.dart';
import 'package:my_app_sochial/layout/Home_Layout/screens/feeds/feeds.dart';
import 'package:my_app_sochial/models/usersModel.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/state.dart';
import 'package:my_app_sochial/shared/Cubit/LoginCubit/states.dart';

import '../../../Components/components.dart';
import '../../../layout/Home_Layout/screens/notifications/notifications.dart';

class socialCubit extends Cubit<socialStates> {
  socialCubit() : super(socialInitialState());
  static socialCubit get(context) => BlocProvider.of(context);
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
    Chats(),
  ];
  void changeBottomNav(int? index) {
    currentIndex = index!;
    emit(socialChangebuttomNavState());
  }
}
