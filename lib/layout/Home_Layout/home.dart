import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/cubit.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/state.dart';
import 'package:my_app_sochial/shared/locale/color/color.dart';

import '../../Components/components.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({Key? key}) : super(key: key);
  colors color = colors();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit, socialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: ConditionalBuilder(
                  condition: socialCubit.get(context).model != null,
                  fallback: (context) => Scaffold(
                        appBar: AppBar(),
                        body: Center(
                          child: LoadingAnimationWidget.prograssiveDots(
                            color: const Color(0xFF1A1A3F),
                            size: 50,
                          ),
                        ),
                      ),
                  builder: ((context) {
                    var cubit = socialCubit.get(context);
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          "مرحباً ${cubit.model!.name}",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      drawer: Drawer(
                        child: Column(
                          children: [
                            AppBar(automaticallyImplyLeading: false),
                            DarkMode()
                          ],
                        ),
                      ),
                      body: Column(
                        children: [
                          if (!FirebaseAuth.instance.currentUser!.emailVerified)
                            Container(
                              color: color.colorscyanop,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Icon(Icons.info_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("الحساب يحتاج الي تفعيل"),
                                  Spacer(),
                                  TextButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                color.colorsred)),
                                    onPressed: () {
                                      FirebaseAuth.instance.currentUser!
                                          .sendEmailVerification()
                                          .then((value) {
                                        toastStyle(
                                            context: context,
                                            massege:
                                                'تم ارسال كود التفعيل بنجاح',
                                            colortoast: color.colorsgreen);
                                      }).catchError((onError) {
                                        print(onError.toString());
                                      });
                                    },
                                    child: Text("تفعيل الان"),
                                  )
                                ],
                              ),
                            ),
                          Expanded(
                              child: Container(
                                  child: cubit.homeScreen[cubit.currentIndex]))
                        ],
                      ),
                      bottomNavigationBar: BottomNavigationBar(
                        onTap: (index) {
                          cubit.changeBottomNav(index);
                        },
                        currentIndex: cubit.currentIndex,
                        items: [
                          BottomNavigationBarItem(
                              icon: Icon(
                                Icons.home,
                              ),
                              label: "الرئيسية"),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.notifications_none),
                              label: "الاشعارات"),
                        ],
                      ),
                    );
                  })));
        });
  }
}
