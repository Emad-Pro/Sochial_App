import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:my_app_sochial/shared/Cubit/SettingCubit/state.dart';

import '../shared/Cubit/SettingCubit/cubit.dart';

Widget textFormFiledDefult({
  required Icon prefixicon,
  required String HintText,
  MaterialButton? suffixIcon,
  TextInputType? typekeyboard,
  TextEditingController? FormFielController,
  String? Function(String?)? validate,
  EdgeInsetsGeometry? paddingcontainer,
  required bool ispassword,
  bool? readonly,
}) =>
    Container(
      padding: paddingcontainer,
      child: TextFormField(
        readOnly: readonly ?? false,
        keyboardType: typekeyboard,
        controller: FormFielController,
        validator: validate,
        obscureText: ispassword,
        decoration: InputDecoration(
          prefixIcon: prefixicon,
          hintText: HintText,
          suffixIcon: suffixIcon,
        ),
      ),
    );
Widget materialButtonClick({
  required String textbtn,
  VoidCallback? clickbtn,
}) =>
    MaterialButton(
      color: Color.fromARGB(255, 50, 158, 133),
      padding: const EdgeInsets.all(10),
      minWidth: double.infinity,
      onPressed: clickbtn,
      child: Text(
        textbtn,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
void navigtorPushClick(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (contex) => Widget,
    ));

void toastStyle({
  required context,
  String? massege,
  Color? colortoast,
}) =>
    showToast(massege,
        context: context,
        animation: StyledToastAnimation.slideFromLeft,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.top,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear,
        backgroundColor: colortoast);

Widget DarkMode() => BlocConsumer<SettingCubit, SettingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text("الوضع الليلي"),
                  const SizedBox(
                    width: 15,
                  ),
                  FlutterSwitch(
                      value: SettingCubit.get(context).DarkMode,
                      padding: 8.0,
                      showOnOff: true,
                      onToggle: (value) {
                        SettingCubit.get(context).toggleTheme();
                      })
                ],
              )
            ],
          ),
        );
      },
    );
String? uId;
