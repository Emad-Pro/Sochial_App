import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
                /*ElevatedButton(
                    onPressed: () {
                      socialCubit.get(context).getPostData();
                    },
                    child: Text("data")),*/
                ConditionalBuilder(
                  condition: socialCubit.get(context).posts.length > 0 &&
                      socialCubit.get(context).model != null,
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  builder: (context) => ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: socialCubit.get(context).posts.length,
                      itemBuilder: ((context, index) {
                        return buildPostItem(context, index,
                            model: socialCubit.get(context).posts[index]);
                      })),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
          }),
    );
  }
}
