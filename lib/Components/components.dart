import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

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
            prefixIcon: prefixicon, hintText: HintText, suffixIcon: suffixIcon),
      ),
    );
Widget materialButtonClick({required String textbtn, VoidCallback? clickbtn}) =>
    MaterialButton(
      color: Colors.cyan,
      padding: EdgeInsets.all(10),
      minWidth: double.infinity,
      child: Text(
        textbtn,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onPressed: clickbtn,
    );
void navigtorPushClick(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (contex) => Widget));

void toastStyle({required context, String? massege, Color? colortoast}) =>
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
