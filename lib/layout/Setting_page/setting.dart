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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("الوضع الليلي"),
                MaterialButton(
                    child: SettingCubit.get(context).DarkMode
                        ? Text("تشغيل")
                        : Text("ايقاف"),
                    onPressed: () {
                      SettingCubit.get(context).toggleTheme();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
