import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/cubit.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/state.dart';

import '../../../Components/components.dart';

class editProfile extends StatelessWidget {
  editProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final updateFormKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    TextEditingController relationshipController = TextEditingController();
    TextEditingController educationController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    socialCubit.get(context).dateController.text =
        socialCubit.get(context).model!.date!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<socialCubit, socialStates>(
        listener: (context, state) {
          if (state is socialUpdateDataSuccessState) {
            toastStyle(
                context: context,
                massege: "تم تحديث البيانات بنجاح",
                colortoast: Colors.blue);
          }
        },
        builder: (context, state) {
          socialCubit cubit = socialCubit.get(context);
          nameController.text = cubit.model!.name!;
          bioController.text = cubit.model!.bio!;
          relationshipController.text = cubit.model!.relationship!;
          educationController.text = cubit.model!.education!;
          phoneController.text = cubit.model!.phone!;
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Text(
                "تعديل الملف الشخصي",
                style: TextStyle(fontSize: 15),
              ),
            ),
            body: state is socialUpdateDataLoadingState
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("جاري تحديث البيانات"),
                        SizedBox(
                          height: 15,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Form(
                        key: updateFormKey,
                        child: Column(
                          children: [
                            editProfileForm(
                                name: "الاسم",
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء ادخال الاسم';
                                  }
                                  return null;
                                }),
                            editProfileForm(
                                name: "رقم الهاتف",
                                controller: phoneController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء ادخال رقم الهاتف';
                                  }
                                  return null;
                                }),
                            editProfileForm(
                                name: "السيرة",
                                controller: bioController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'لا يمكنك ترك حقل السيرة الذاتية فارغ';
                                  }
                                  return null;
                                }),
                            editProfileForm(
                                name: "الحالة الاجتماعية",
                                controller: relationshipController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء ادخال الحالة الاجتماعية';
                                  }
                                  return null;
                                }),
                            Card(
                              child: GestureDetector(
                                onTap: () => socialCubit
                                    .get(context)
                                    .SelectDate(context),
                                child: AbsorbPointer(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text("تاريخ الميلاد"),
                                        Expanded(
                                          child: TextFormField(
                                            controller: socialCubit
                                                .get(context)
                                                .dateController,
                                            keyboardType:
                                                TextInputType.datetime,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              suffixIcon: Icon(
                                                Icons.date_range_rounded,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            editProfileForm(
                                name: "التعليم",
                                controller: educationController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'لا يمكنك ترك الحقل فارغ';
                                  }
                                  return null;
                                }),
                            ElevatedButton(
                              onPressed: () {
                                if (updateFormKey.currentState!.validate()) {
                                  socialCubit.get(context).updateData(
                                        name: nameController.text,
                                        relationship:
                                            relationshipController.text,
                                        date: socialCubit
                                            .get(context)
                                            .dateController
                                            .text,
                                        education: educationController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                }
                              },
                              child: Text(
                                "تحديث",
                              ),
                            ),
                          ],
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
