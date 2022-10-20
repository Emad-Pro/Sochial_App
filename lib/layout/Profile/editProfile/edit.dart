import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/cubit.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/state.dart';

import '../../../Components/components.dart';

class editProfile extends StatelessWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<socialCubit, socialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Text(
                "تعديل الملف الشخصي",
                style: TextStyle(fontSize: 15),
              ),
            ),
            body: Column(
              children: [
                BuildProfile(context, model: socialCubit.get(context).model)
              ],
            ),
          );
        },
      ),
    );
  }
}
