import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Components/components.dart';
import '../../layout/Home_Layout/home.dart';
import '../../shared/Cubit/RegisterCubit/cubit.dart';
import '../../shared/Cubit/RegisterCubit/states.dart';
import '../LoginScreen/Login.dart';

class Register extends StatelessWidget {
  TextEditingController NameController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => socialRegisterCubit(),
      child: BlocConsumer<socialRegisterCubit, socialRegisterState>(
        listener: (context, state) {
          if (state is socialCreateUserSuccessState) {
            navigtorPushClick(context, LoginScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: EdgeInsetsDirectional.all(20),
                child: Form(
                  key: formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.asset("lib/assets/Image/RegisterScreen/register.png"),
                          ),
                        ),
                        Text("أنشاء حساب"),
                        textFormFiledDefult(
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "أدخل الاسم ";
                              }
                              return null;
                            },
                            FormFielController: NameController,
                            ispassword: false,
                            prefixicon: Icon(Icons.perm_identity),
                            HintText: "الاسم بالكامل"),
                        SizedBox(
                          height: 15,
                        ),
                        textFormFiledDefult(
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "أدخل البريد الالكتروني ";
                              }
                              return null;
                            },
                            FormFielController: EmailController,
                            ispassword: false,
                            prefixicon: Icon(Icons.alternate_email_outlined),
                            HintText: "البريد الالكتروني"),
                        SizedBox(
                          height: 15,
                        ),
                        textFormFiledDefult(
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "أدخل كلمة السر ";
                              }
                              return null;
                            },
                            FormFielController: PhoneController,
                            ispassword: false,
                            prefixicon: Icon(Icons.phone),
                            HintText: "رقم الهاتف"),
                        SizedBox(
                          height: 15,
                        ),
                        textFormFiledDefult(
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "أدخل رقم الهاتف ";
                              }
                              return null;
                            },
                            FormFielController: PasswordController,
                            ispassword: socialRegisterCubit.get(context).PasswordVisibility,
                            prefixicon: Icon(Icons.lock_outline_rounded),
                            suffixIcon: MaterialButton(
                              minWidth: 0,
                              height: 0,
                              focusElevation: 10,
                              onPressed: () {
                                socialRegisterCubit.get(context).ispassword();
                              },
                              child: Icon(socialRegisterCubit.get(context).suffixicon),
                            ),
                            HintText: "كلمة المرور"),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(maxLines: 1, "بالتسجيل ، أنت توافق على"),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                maxLines: 1,
                                "سياسة الخصوصية والشروط",
                                style: TextStyle(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          builder: (context) => materialButtonClick(
                              textbtn: "تسجيل",
                              clickbtn: () async {
                                if (formkey.currentState!.validate()) {
                                  socialRegisterCubit.get(context).userRegister(
                                      name: NameController.text,
                                      email: EmailController.text,
                                      password: PasswordController.text,
                                      phone: PhoneController.text);
                                }
                              }),
                          fallback: ((context) => Center(child: CircularProgressIndicator())),
                          condition: state is! socialRegisterLoadingState,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(" لديك حساب بالفعل ؟"),
                            TextButton(
                                onPressed: () {
                                  //  NavigateToCantBack(context, LoginScreen());
                                },
                                child: Text("تسجيل الدخول"))
                          ],
                        )
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
