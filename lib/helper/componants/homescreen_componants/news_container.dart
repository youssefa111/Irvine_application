import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import '../../../model/news_model.dart';

class NewsContainer extends StatelessWidget {
  final NewsModel newsModel;
  final String newsID;

  const NewsContainer({Key? key, required this.newsModel, required this.newsID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenCubit(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      newsModel.iconLetter,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  newsModel.reporterName,
                ),
                // if (isAgency)
                //   SizedBox(
                //     width: 5,
                //   ),
                // if (isAgency)
                //   Text(
                //     'AGENCY',
                //     style: TextStyle(
                //         fontWeight: FontWeight.bold, color: Colors.green),
                //   ),
                Spacer(),
                Text(
                  newsModel.date,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              newsModel.newsTitle,
              style: Theme.of(context).textTheme.button!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Text(newsModel.newsContent),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(newsID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          '( ${newsModel.newsThanks} Thanks , ${newsModel.newsReplies} Replies )',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        );
                      }
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Text(
                        '(${data['newsThanks']} Thanks , ${data['newsReplies']} Replies )',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      );
                    }),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                BlocConsumer<HomeScreenCubit, HomeScreenState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return NewsReactButton(
                        icon: FontAwesomeIcons.heart,
                        text: 'Thank',
                        fun: () => HomeScreenCubit.get(context).interactThank(
                              key
                                  .toString()
                                  .replaceAll(RegExp('\[<\'>\]'), '')
                                  .replaceAll(']', '')
                                  .replaceAll('[', ''),
                            ));
                  },
                ),
                SizedBox(
                  width: 15,
                ),
                NewsReactButton(
                    icon: FontAwesomeIcons.reply, text: 'Reply', fun: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewsReactButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? fun;
  const NewsReactButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.fun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => fun!(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FaIcon(
            icon,
            size: 18,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            text,
          ),
        ],
      ),
    );
  }
}
