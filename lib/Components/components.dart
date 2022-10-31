import 'package:circular_menu/circular_menu.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_app_sochial/models/postModel.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/cubit.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/state.dart';
import 'package:my_app_sochial/shared/Cubit/SettingCubit/state.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../layout/Profile/editProfile/edit.dart';
import '../shared/Cubit/SettingCubit/cubit.dart';

String? uId;
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
                      })
                ],
              )
            ],
          ),
        );
      },
    );

/****************************Home Layout */
Widget buildPostItem(
  context,
  index, {
  required postModel model,
}) =>
    Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<socialCubit, socialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            TextEditingController commentController = TextEditingController();
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            '${socialCubit.get(context).model!.image}',
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
                                  Text("${model.name}"),
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
                                "${model.date}",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        PullDownButton(
                          itemBuilder: (context) => [
                            PullDownMenuItem(
                              title: 'تعديل',
                              onTap: () {},
                            ),
                            const PullDownMenuDivider(),
                            PullDownMenuItem(
                              title: 'حذف',
                              onTap: () {
                                socialCubit.get(context).deletePost(model.postId);
                              },
                            ),
                          ],
                          position: PullDownMenuPosition.under,
                          buttonBuilder: (context, showMenu) => CupertinoButton(
                            onPressed: showMenu,
                            padding: EdgeInsets.zero,
                            child: const Icon(CupertinoIcons.ellipsis_circle),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    if (model.text != '')
                      Text(
                        "${model.text}",
                        textDirection: TextDirection.rtl,
                      ),
                    /*Container(
      
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
      
                                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      
                                child: Text(
      
                                  "#Ea",
      
                                  style: TextStyle(color: Colors.blue),
      
                                ),
      
                              ),
      
                            ),
      
                          ],
      
                        ),
      
                      ),*/
                    SizedBox(
                      height: 10,
                    ),
                    if (model.postImage != '')
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image(
                          image: NetworkImage("${model.postImage}"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      height: 0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              socialCubit.get(context).likePost(model.postId, index);
                              //socialCubit.get(context).likePost(model.postId);
                              //   socialCubit.get(context).getLikePosts();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    socialCubit.get(context).Likes[index][uId] == true
                                        ? Icons.favorite_sharp
                                        : Icons.favorite_border,
                                    color: socialCubit.get(context).Likes[index][uId] == true
                                        ? Colors.blue
                                        : Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '',
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
                            onTap: () {
                              socialCubit.get(context).getCommentPost(model.postId);
                              socialCubit.get(context).getLikeCommentPost(model.postId);
                              buildCommentVeiw(context);
                            },
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
                                    "",
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
                                    "0",
                                    style: Theme.of(context).textTheme.caption,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                  '${socialCubit.get(context).model!.image}',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "كتابة تعليق",
                                      hintStyle: TextStyle(fontSize: 12)),
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                      title: Text(
                                        "كتابة تعليق",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      content: Row(children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              socialCubit.get(context).addCommentPost(model.postId,
                                                  comment: commentController.text);
                                            },
                                            child: Text("ارسال")),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("الغاء")),
                                      ]),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.commit_rounded),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "ارسال",
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
          }),
    );

Widget createNewPost(context, {model}) => Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<socialCubit, socialStates>(
        listener: (context, state) {},
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
buildCommentVeiw(context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => BlocConsumer<socialCubit, socialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is socialGetCommentPostLoadingState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        Card(
                            child: MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Row(children: [
                            Text("${socialCubit.get(context).likeCount}"),
                            Icon(Icons.favorite_border)
                          ]),
                        )),
                        Spacer(),
                        Card(
                            child: MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Row(children: [
                            Text("${socialCubit.get(context).commentCount}"),
                            Icon(Icons.comment_outlined)
                          ]),
                        )),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                child: Image(
                                                    image: NetworkImage(
                                                        "${socialCubit.get(context).comment[index].image}")),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${socialCubit.get(context).comment[index].name}"),
                                                  Text(
                                                      "${socialCubit.get(context).comment[index].date}",
                                                      style: Theme.of(context).textTheme.caption),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                                        ],
                                      ),
                                      Divider(
                                        indent: 15,
                                        endIndent: 15,
                                      ),
                                      Text("${socialCubit.get(context).comment[index].comment}")
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          itemCount: socialCubit.get(context).comment.length),
                    ),
                  ],
                );
        }),
  );
}
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