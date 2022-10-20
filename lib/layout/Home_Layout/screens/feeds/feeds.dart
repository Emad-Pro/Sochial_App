import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_sochial/Components/components.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/cubit.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/state.dart';
import 'package:my_app_sochial/shared/locale/color/color.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<socialCubit, socialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: ((context, index) {
                      return BuildPostItem(context,
                          model: socialCubit.get(context).model);
                    })),
                SizedBox(
                  height: 10,
                )
              ],
            );
          }),
    );
  }
}
