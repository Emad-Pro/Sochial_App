import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_sochial/shared/Cubit/SettingCubit/cubit.dart';
import 'package:my_app_sochial/shared/Cubit/SettingCubit/state.dart';

import 'package:my_app_sochial/shared/locale/SharedPrefrences/CacheHelper.dart';
import 'package:my_app_sochial/shared/locale/blocObserver/blocObserver.dart';

import 'Modules/LoginScreen/Login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  HttpOverrides.global = new MyHttpOverrides();
  await CacheHelper.init();
  bool? DarkMode = CacheHelper.GetSaveData(key: 'DarkMode');
  runApp(Main(DarkMode ?? false));
}

class Main extends StatelessWidget {
  final bool DarkMode;
  Main(this.DarkMode);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  SettingCubit()..toggleTheme(DarkShared: DarkMode))
        ],
        child: BlocBuilder<SettingCubit, SettingCubitState>(
            builder: (context, state) => MaterialApp(
                themeMode: SettingCubit.get(context).DarkMode
                    ? ThemeMode.dark
                    : ThemeMode.light,
                theme: ThemeData.light(
                  useMaterial3: true,
                ).copyWith(),
                darkTheme: ThemeData.dark(
                  useMaterial3: true,
                ),
                home: LoginScreen())));
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
