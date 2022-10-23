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
    TextEditingController nameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    TextEditingController relationshipController = TextEditingController();
    TextEditingController educationController = TextEditingController();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<socialCubit, socialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          socialCubit cubit = socialCubit.get(context);
          nameController.text = cubit.model!.name!;
          bioController.text = cubit.model!.bio!;
          relationshipController.text = cubit.model!.relationship!;
          educationController.text = cubit.model!.education!;
          socialCubit.get(context).dateController.text = cubit.model!.date!;
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Text(
                "تعديل الملف الشخصي",
                style: TextStyle(fontSize: 15),
              ),
            ),
            body: Container(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    editProfileForm(name: "الاسم", controller: nameController),
                    editProfileForm(name: "السيرة", controller: bioController),
                    editProfileForm(
                        name: "الحالة الاجتماعية",
                        controller: relationshipController),
                    Card(
                      child: GestureDetector(
                        onTap: () =>
                            socialCubit.get(context).SelectDate(context),
                        child: AbsorbPointer(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text("تاريخ الميلاد"),
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        socialCubit.get(context).dateController,
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      suffixIcon: Icon(
                                        Icons.dialpad,
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
                        name: "التعليم", controller: educationController),
                    ElevatedButton(
                      onPressed: () {
                        print(nameController.text);
                        print(bioController.text);
                        print(relationshipController.text);

                        print(educationController.text);
                      },
                      child: Text(
                        "ارسال",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
