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
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  await CacheHelper.init();
  bool? darkMode = CacheHelper.GetSaveData(key: 'DarkMode');
  uId = CacheHelper.GetSaveData(key: 'uId');
  Widget? widget;
  Bloc.observer = MyBlocObserver();
  if (uId != null) {
    widget = HomeLayout();
  } else {
    widget = LoginScreen();
  }
  runApp(Main(darkMode ?? false, widget));
}

class Main extends StatelessWidget {
  final Widget startWidget;
  final bool darkMode;
  const Main(this.darkMode, this.startWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingCubit()..toggleTheme(DarkShared: darkMode),
        ),
        BlocProvider(
            create: (context) => socialCubit()
              ..getUserData()
              ..getPostData())
      ],
      child: BlocBuilder<SettingCubit, SettingStates>(
        builder: (context, state) => MaterialApp(
          themeMode: SettingCubit.get(context).DarkMode ? ThemeMode.dark : ThemeMode.light,
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
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

/*import 'package:flutter/material.dart';

void main() {
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with TickerProviderStateMixin {
  TabController? mycontroller;
  @override
  void initState() {
    mycontroller = TabController(
      length: 5,
      vsync: this,
    );
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text("asd"),
                bottom: TabBar(
                  controller: mycontroller,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.abc),
                    ),
                    Tab(
                      icon: Icon(Icons.abc),
                    ),
                    Tab(
                      icon: Icon(Icons.abc),
                    ),
                    Tab(
                      icon: Icon(Icons.abc),
                    ),
                    Tab(
                      icon: Icon(Icons.abc),
                    ),
                  ],
                )),
            body: TabBarView(controller: mycontroller, children: [
              Container(
                child: Text("data1"),
              ),
              Container(
                child: Text("data2"),
              ),
              Container(
                child: Text("data3"),
              ),
              Container(
                child: Text("data4"),
              ),
              Container(
                child: Text("data4"),
              ),
            ])));
  }
}*/
