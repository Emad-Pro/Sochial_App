import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:my_app_sochial/Modules/RegisterScreen/Register.dart';

import '../../Components/components.dart';
import '../../shared/Cubit/LoginCubit/cubit.dart';
import '../../shared/Cubit/LoginCubit/states.dart';
import '../../shared/Cubit/SettingCubit/cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController EmailController = TextEditingController();
    TextEditingController PasswordController = TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: ((context) => SochialLoginCubit()),
      child: BlocConsumer<SochialLoginCubit, SochialLoginState>(
        listener: (context, state) {
          if (state is SochialLoginSuccessState) {
            toastStyle(
                context: context,
                massege: "تم تسجيل الدخول بنجاح",
                colortoast: Colors.green);
          }
          if (state is SochialLoginErorrState) {
            toastStyle(
                context: context, massege: state.Erorr, colortoast: Colors.red);
          }
        },
        builder: (context, state) {
          return Scaffold(
            drawer: Drawer(
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        SettingCubit.get(context).toggleTheme();
                      },
                      child: Text("الوضع الليلي"))
                ],
              ),
            ),
            appBar: AppBar(
              actions: [],
            ),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: EdgeInsetsDirectional.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("lib/assets/Image/LoginScreen/login.png"),
                        Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        textFormFiledDefult(
                          paddingcontainer: EdgeInsets.symmetric(vertical: 10),
                          ispassword: false,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "أدخل البريد الالكتروني";
                            }
                            return null;
                          },
                          FormFielController: EmailController,
                          HintText: "البريد الالكتروني",
                          prefixicon: Icon(Icons.alternate_email_outlined),
                          typekeyboard: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        textFormFiledDefult(
                            ispassword: SochialLoginCubit.get(context)
                                .PasswordVisibility,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "أدخل كلمة المرور";
                              }
                              return null;
                            },
                            FormFielController: PasswordController,
                            prefixicon: Icon(Icons.lock_outline_rounded),
                            HintText: "كلمة المرور",
                            suffixIcon: MaterialButton(
                              minWidth: 0,
                              height: 0,
                              focusElevation: 10,
                              onPressed: () {
                                SochialLoginCubit.get(context).ispassword();
                              },
                              child: Icon(
                                SochialLoginCubit.get(context).suffixicon,
                              ),
                            ),
                            typekeyboard: TextInputType.text),
                        SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            //    BtnPushClick(context, ForgotPasswortScreen());
                          },
                          child: Text(
                            "نسيت كلمة المرور?",
                            style: TextStyle(),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          builder: (context) => materialButtonClick(
                              textbtn: "دخول",
                              clickbtn: () async {
                                if (formkey.currentState!.validate()) {
                                  SochialLoginCubit.get(context).userLogin(
                                    email: EmailController.text,
                                    password: PasswordController.text,
                                  );
                                }
                              }),
                          fallback: ((context) =>
                              Center(child: CircularProgressIndicator())),
                          condition: state is! SochialLoginLoadingState,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            child: Center(
                              child: Text(
                                "او ",
                                textAlign: TextAlign.center,
                              ),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("مستخدم جديد ؟"),
                            TextButton(
                                onPressed: () {
                                  navigtorPushClick(context, Register());
                                },
                                child: Text("أنشاء حساب"))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
