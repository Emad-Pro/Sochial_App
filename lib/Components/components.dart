import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:my_app_sochial/shared/Cubit/SettingCubit/state.dart';

import '../layout/Profile/editProfile/edit.dart';
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

/****************************Home Layout */
Widget BuildPostItem(context, {model}) =>
    BlocConsumer<SettingCubit, SettingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 20,
          margin: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              10.0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=900&t=st=1666008947~exp=1666009547~hmac=292195718fb32e11cd2928c814e8c06c0895f3338810d15739dec8eba1056b60',
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("Emad Younis"),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 15,
                              )
                            ],
                          ),
                          Text(
                            "Julay 21, 2022 at 11:22",
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_horiz),
                    )
                  ],
                ),
                const Divider(),
                Text(
                    "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق."),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 1,
                    children: [
                      Container(
                        height: 25,
                        child: MaterialButton(
                          disabledElevation: 0,
                          elevation: 0,
                          onPressed: () {},
                          minWidth: 0,
                          height: 0,
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          child: Text(
                            "#Ea",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=900&t=st=1666010363~exp=1666010963~hmac=f1009b33644ea61d56dee938ef33ded1bf80b4e557592749cfc691dc8b99801c'))),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite_border),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "200",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.comment),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "200",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_right),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "200",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=900&t=st=1666008947~exp=1666009547~hmac=292195718fb32e11cd2928c814e8c06c0895f3338810d15739dec8eba1056b60',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "كتابة تعليق",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite_border),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "احببته",
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
Widget BuildProfile(context, {model}) => Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 200,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 180,
                    image: NetworkImage("${model.coverimage}"),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: 45,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text("${model.name}"),
          ),
          Container(
            child: Text(
              "${model.bio}",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
Widget BuildFollowing(context) => Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Text("85"),
                  Text(
                    "Following",
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Text("20K"),
                  Text(
                    "Followers",
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Text("311"),
                  Text(
                    "Photos",
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Column(
                children: [
                  Text("223"),
                  Text(
                    "Post",
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
/****************************Home Layout */