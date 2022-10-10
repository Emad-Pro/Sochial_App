import 'package:flutter/material.dart';

import '../../shared/SettingCubit/cubit.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Text"),
          onPressed: () {
            SettingCubit.get(context).toggleTheme();
          },
        ),
      ),
    );
  }
}
