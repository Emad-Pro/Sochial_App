import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_app_sochial/Modules/LoginScreen/Login.dart';
import 'package:my_app_sochial/models/postModel.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/cubit.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/state.dart';
import 'package:my_app_sochial/shared/Cubit/SettingCubit/state.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../layout/Profile/editProfile/edit.dart';
import '../shared/Cubit/SettingCubit/cubit.dart';
import '../shared/locale/SharedPrefrences/CacheHelper.dart';

String? uId = FirebaseAuth.instance.currentUser!.uid;
Widget textFormFiledDefult({
  Icon? prefixicon,
  required String HintText,
  MaterialButton? suffixIcon,
  TextInputType? typekeyboard,
  TextEditingController? FormFielController,
  String? Function(String?)? validate,
  EdgeInsetsGeometry? paddingcontainer,
  required bool ispassword,
  bool? readonly,
}) =>
    TextFormField(
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

Widget darkMode() => BlocConsumer<SettingCubit, SettingStates>(
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
                      }),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    CacheHelper.clearData(key: "uId").then((value) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false);
                    });
                    uId = '';
                  },
                  child: Text("تسجيل خروج"))
            ],
          ),
        );
      },
    );

/****************************Home Layout */

Widget createNewPost(context, {model}) => Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<socialCubit, socialStates>(
        listener: (context, state) {
          if (state is socialCreatePostSuccessState) {
            toastStyle(
                context: context, massege: "تم إضافة المنشور بنجاح", colortoast: Colors.green);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          TextEditingController postController = TextEditingController();
          return state is socialCreatePostLoadingState
              ? Center(child: CircularProgressIndicator())
              : Scaffold(
                  body: Column(
                    children: [
                      AppBar(
                        title: Text(
                          "المنشورات",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                '${model.model.image}',
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
                                    children: [
                                      Text("${model.model.name}"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Public",
                                    style: Theme.of(context).textTheme.bodySmall,
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
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: TextFormField(
                            controller: postController,
                            maxLines: 10,
                            decoration:
                                InputDecoration(border: OutlineInputBorder(), hintText: "بم تفكر"),
                          ),
                        ),
                      ),
                      if (socialCubit.get(context).imagePost != null)
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(15),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Image(
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 230,
                                    image: FileImage(model.imagePost)),
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                  ),
                                  onPressed: () {
                                    socialCubit.get(context).deletePostImage();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ElevatedButton(
                          onPressed: () {
                            if (socialCubit.get(context).imagePost == null) {
                              //add post without Image
                              socialCubit.get(context).createNewPost(text: postController.text);
                            } else {
                              //add post with Image
                              socialCubit.get(context).uploadPost(text: postController.text);
                            }
                          },
                          child: Text("إضافة المنشور")),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                socialCubit.get(context).getImagePost();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.image),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text("اضافة صورة")
                                ],
                              ))
                        ],
                      )
                    ],
                  ),
                );
        },
      ),
    );
Widget buildProfile(context, {model, profilemodel}) => Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            height: 250,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        onTap: () {
                          buildImageView(context, imageurl: model.model.coverimage);
                        },
                        child: Image(
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 230,
                            image: NetworkImage("${model.model.coverimage}")),
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => BlocConsumer<socialCubit, socialStates>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return state is socialUploadProfileCoverLoadingState
                                    ? Center(
                                        child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const CircularProgressIndicator(),
                                          Text("جار رفع صورة الغلاف برجاء الانتظار")
                                        ],
                                      ))
                                    : AlertDialog(
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("تحميل صورة الغلاف"),
                                              ConditionalBuilder(
                                                condition: model.coverImage != null,
                                                builder: (context) => Image(
                                                  image: FileImage(model.coverImage),
                                                ),
                                                fallback: (context) => Text("اختر الصورة"),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  socialCubit.get(context).getCoverImage();
                                                },
                                                icon: Icon(Icons.camera),
                                              ),
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      model.uploadCoverImage();
                                                    },
                                                    child: Text("رفع"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      model.coverImage = null;
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text("الغاء"),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.photo_camera,
                        ),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  radius: 60,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Container(
                        height: 200,
                        child: InkWell(
                          onTap: () {
                            buildImageView(context, imageurl: model.model.image);
                          },
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(
                              '${model.model.image}',
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => BlocConsumer<socialCubit, socialStates>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return state is socialUploadProfileImageLoadingState
                                    ? Center(
                                        child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const CircularProgressIndicator(),
                                          Text("جار رفع الصورة برجاء الانتظار")
                                        ],
                                      ))
                                    : AlertDialog(
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("تحميل الصورة"),
                                              ConditionalBuilder(
                                                condition: model.profileimage != null,
                                                builder: (context) => Image(
                                                  image: FileImage(model.profileimage),
                                                ),
                                                fallback: (context) => Text("اختر الصورة"),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  socialCubit.get(context).getProfileImage();
                                                },
                                                icon: Icon(Icons.camera),
                                              ),
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      model.uploadProfileImage();
                                                    },
                                                    child: Text("رفع"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      model.profileimage = null;
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text("الغاء"),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              },
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.photo_camera,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              "${model.model.name}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            child: Text(
              "${model.model.bio}",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildProfileInfo(
                        iconData: Icons.leaderboard_rounded, text: model.model.education),
                    SizedBox(
                      height: 10,
                    ),
                    buildProfileInfo(iconData: Icons.date_range, text: model.model.date),
                    SizedBox(
                      height: 10,
                    ),
                    buildProfileInfo(
                        iconData: Icons.settings_accessibility_outlined,
                        text: model.model.relationship),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
Widget buildProfileInfo({IconData? iconData, String? text}) => Row(
      children: [
        Icon(iconData),
        SizedBox(
          width: 15,
        ),
        Text(text!)
      ],
    );
buildImageView(context, {String? imageurl}) => showDialog(
      context: context,
      builder: (context) => Container(
          child: PhotoView(
        imageProvider: NetworkImage("${imageurl}"),
      )),
    );
Widget buildFollowing(context) => Container(
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

/**********************************ProfileEdit */
Widget editProfileForm(
    {String? name,
    TextEditingController? controller,
    String? Function(String?)? validator,
    int? length,
    Widget? suffix,
    Widget? suffixicon,
    VoidCallback? onTap}) {
  return Card(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(padding: EdgeInsetsDirectional.only(start: 10, end: 10), child: Text(name!)),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none, suffix: suffix, suffixIcon: suffixicon),
                controller: controller,
                validator: validator,
                maxLength: length,
                maxLines: 1,
                onTap: onTap,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
/**********************************ProfileEdit */