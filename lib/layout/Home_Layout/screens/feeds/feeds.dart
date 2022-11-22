import 'package:auto_direction/auto_direction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';
import 'package:my_app_sochial/Components/components.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/cubit.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/state.dart';
import 'package:my_app_sochial/shared/locale/color/color.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../../../models/postModel.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocConsumer<socialCubit, socialStates>(
              builder: (ctx, state) {
                return ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: socialCubit.get(context).posts.length,
                    itemBuilder: ((context, index) {
                      return buildPostItem(context, index,
                          model: socialCubit.get(context).posts[index]);
                    }));
              },
              listener: (ctx, state) {}),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget buildPostItem(
    context,
    index, {
    required postModel model,
  }) {
    TextEditingController commentController = TextEditingController();
    return BlocConsumer<socialCubit, socialStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Card(
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          socialCubit.get(context).model!.image.toString(),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
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
                          const PullDownMenuDivider(),
                          PullDownMenuItem(
                            isDestructive: true,
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
                    Container(
                      width: double.infinity,
                      child: AutoDirection(
                        text: model.text!,
                        child: Text(
                          "${model.text}",
                        ),
                      ),
                    ),
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
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                socialCubit.get(context).Likes[index]
                                            [socialCubit.get(context).currentUid] ==
                                        true
                                    ? Iconsax.like_1
                                    : Iconsax.like_1,
                                color: socialCubit.get(context).Likes[index]
                                            [socialCubit.get(context).currentUid] ==
                                        true
                                    ? Colors.blue
                                    : null,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            buildCommentVeiw(context: context, postId: model.postId);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Iconsax.message),
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
                              child: AutoDirection(
                                text: commentController.text,
                                child: TextField(
                                  controller: commentController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "كتابة تعليق",
                                      hintStyle: TextStyle(fontSize: 12)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (commentController.text.isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                      title: const Text(
                                        "كتابة تعليق",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      content: Row(children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              if (commentController.text.isEmpty) {
                                                toastStyle(
                                                    context: context,
                                                    massege: "لا يمكنك إضافة تعليق فارغ",
                                                    colortoast: Colors.red);
                                              } else {
                                                socialCubit.get(context).addCommentPost(
                                                    model.postId,
                                                    comment: commentController.text,
                                                    name: model.name,
                                                    image: model.image);
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: Text("ارسال")),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("الغاء")),
                                      ]),
                                    ),
                                  );
                                });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.send1),
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
          ),
        );
      }),
    );
  }

  buildCommentVeiw({context, required String? postId}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => BlocProvider.value(
              value: socialCubit.get(context)..getCommentPost(postId),
              child: BlocConsumer<socialCubit, socialStates>(
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
                                    Text(" ${socialCubit.get(context).likeCount} "),
                                    Icon(Iconsax.like_1),
                                  ]),
                                )),
                                Spacer(),
                                Card(
                                    child: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                  child: Row(children: [
                                    Text(" ${socialCubit.get(context).commentCount} "),
                                    Icon(Iconsax.message),
                                  ]),
                                )),
                              ],
                            ),
                            Divider(
                              height: 10,
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
                                            children: [
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage: NetworkImage(
                                                            "${socialCubit.get(context).comment[index].image}"),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                              "${socialCubit.get(context).comment[index].name}"),
                                                          Text(
                                                              "${socialCubit.get(context).comment[index].date}",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .caption),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  Directionality(
                                                    textDirection: TextDirection.rtl,
                                                    child: PullDownButton(
                                                      itemBuilder: (context) => [
                                                        const PullDownMenuDivider(),
                                                        PullDownMenuItem(
                                                          isDestructive: true,
                                                          title: 'حذف',
                                                          onTap: () {
                                                            socialCubit.get(context).deleteComment(
                                                                commentId: socialCubit
                                                                    .get(context)
                                                                    .idComment[index],
                                                                postId: postId);
                                                          },
                                                        ),
                                                      ],
                                                      position: PullDownMenuPosition.under,
                                                      buttonBuilder: (context, showMenu) =>
                                                          CupertinoButton(
                                                        onPressed: showMenu,
                                                        padding: EdgeInsets.zero,
                                                        child: const Icon(
                                                            CupertinoIcons.ellipsis_circle),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                indent: 15,
                                                endIndent: 15,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                child: AutoDirection(
                                                  text: socialCubit
                                                      .get(context)
                                                      .comment[index]
                                                      .comment
                                                      .toString(),
                                                  child: Text(
                                                      "${socialCubit.get(context).comment[index].comment}"),
                                                ),
                                              )
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
                },
              ),
            ));
  }
}
