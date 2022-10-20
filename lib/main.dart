import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_sochial/layout/Home_Layout/home.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/cubit.dart';
import 'package:my_app_sochial/shared/Cubit/SettingCubit/cubit.dart';
import 'package:my_app_sochial/shared/Cubit/SettingCubit/state.dart';

import 'package:my_app_sochial/shared/locale/SharedPrefrences/CacheHelper.dart';
import 'package:my_app_sochial/shared/locale/blocObserver/blocObserver.dart';

import 'Components/components.dart';
import 'Modules/LoginScreen/Login.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  HttpOverrides.global = new MyHttpOverrides();
  await CacheHelper.init();
  bool? DarkMode = CacheHelper.GetSaveData(key: 'DarkMode');
  uId = CacheHelper.GetSaveData(key: 'uId');
  late Widget? widget;

  if (uId != null) {
    widget = HomeLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(Main(DarkMode ?? false, widget));
}

class Main extends StatelessWidget {
  final Widget startWidget;
  final bool DarkMode;
  Main(this.DarkMode, this.startWidget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SettingCubit()..toggleTheme(DarkShared: DarkMode),
        ),
        BlocProvider(create: (context) => socialCubit()..getUserData())
      ],
      child: BlocBuilder<SettingCubit, SettingStates>(
        builder: (context, state) => MaterialApp(
          themeMode: SettingCubit.get(context).DarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          theme: ThemeData.light(
            useMaterial3: true,
          ).copyWith(
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.blue,
            ),
            textTheme: ThemeData.light().textTheme.apply(
                  fontFamily: "Cairo",
                ),
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ).copyWith(
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.teal,
            ),
            textTheme: ThemeData.dark().textTheme.apply(
                  fontFamily: "Cairo",
                ),
          ),
          home: startWidget,
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
