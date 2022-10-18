import 'package:flutter/material.dart';
import 'package:my_app_sochial/shared/locale/color/color.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 20,
            margin: EdgeInsets.all(10),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                const Image(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180,
                  image: NetworkImage(
                      "https://img.freepik.com/free-photo/isolated-shot-woman-uses-smartphone-application-enjoys-browsing-social-media-creats-news-content-makes-online-order-wears-spectacles-casual-jumper-poses-beige-studio-wall_273609-44111.jpg?w=740&t=st=1665997263~exp=1665997863~hmac=58c1d6140c76706b5573e09eb0d9a09c191565f03bb27653776aa0c89c213bae"),
                ),
                Text(
                  "انضم الي اصدقائك",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.black),
                )
              ],
            ),
          ),
          Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 20,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/no-problem-concept-bearded-man-makes-okay-gesture-has-everything-control-all-fine-gesture-wears-spectacles-jumper-poses-against-pink-wall-says-i-got-this-guarantees-something_273609-42817.jpg?w=900&t=st=1666008947~exp=1666009547~hmac=292195718fb32e11cd2928c814e8c06c0895f3338810d15739dec8eba1056b60'),
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
                                children: const [
                                  Text("Emad Younis"),
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
                                "Julay 21, 2022 at 11:22",
                                style: Theme.of(context).textTheme.caption,
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
                    const Divider(),
                    Text(
                        "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق."),
                    Container(
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              child: Text(
                                "#Ea",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=900&t=st=1666010363~exp=1666010963~hmac=f1009b33644ea61d56dee938ef33ded1bf80b4e557592749cfc691dc8b99801c'))),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
