import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_sochial/shared/SettingCubit/cubit.dart';
import 'package:my_app_sochial/shared/SettingCubit/state.dart';
import 'package:my_app_sochial/shared/locale/SharedPrefrences/CacheHelper.dart';
import 'package:my_app_sochial/shared/locale/blocObserver/blocObserver.dart';

import 'layout/Setting_page/setting.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
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
                theme: ThemeData.dark(),
                darkTheme: ThemeData.light(),
                home: const Setting())));
  }
}
