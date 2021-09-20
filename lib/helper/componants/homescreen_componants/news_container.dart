import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_task/helper/componants/homescreen_componants/reply_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

import '../../../business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import '../../../model/news_model.dart';

// ignore: must_be_immutable
class NewsContainer extends StatelessWidget {
  final NewsModel newsModel;
  final String newsID;

  NewsContainer({Key? key, required this.newsModel, required this.newsID})
      : super(key: key);

  bool showReply = false;
  @override
  Widget build(BuildContext context) {
    var userID = FirebaseAuth.instance.currentUser!.uid;
    return BlocProvider(
      create: (context) => HomeScreenCubit(),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey),
        ),
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                height: 5,
              ),
              Divider(
                thickness: 2,
              ),
              StreamBuilder<DocumentSnapshot?>(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .doc(newsID)
                      .snapshots(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              LikeButton(
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    isLiked
                                        ? FontAwesomeIcons.solidHeart
                                        : FontAwesomeIcons.heart,
                                    size: 18,
                                  );
                                },
                                onTap: (bool x) {
                                  return HomeScreenCubit.get(context)
                                      .interactThank(
                                    key
                                        .toString()
                                        .replaceAll(RegExp('\[<\'>\]'), '')
                                        .replaceAll(']', '')
                                        .replaceAll('[', ''),
                                  );
                                },
                                isLiked: newsModel.loveItem == null ||
                                        (newsModel.loveItem != null &&
                                            !newsModel.loveItem
                                                .containsKey(userID))
                                    ? false
                                    : newsModel.loveItem[userID]['isThanked'],
                              ),
                              Text('Thank'),
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.reply,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Reply'),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () =>
                              HomeScreenCubit.get(context).interactThank(
                            key
                                .toString()
                                .replaceAll(RegExp('\[<\'>\]'), '')
                                .replaceAll(']', '')
                                .replaceAll('[', ''),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              LikeButton(
                                likeBuilder: (bool islIked) {
                                  return Icon(
                                    data['loveItem'] != null &&
                                            data['loveItem']
                                                .containsKey(userID) &&
                                            data['loveItem'][userID]
                                                ['isThanked']
                                        ? FontAwesomeIcons.solidHeart
                                        : FontAwesomeIcons.heart,
                                    color: data['loveItem'] != null &&
                                            data['loveItem']
                                                .containsKey(userID) &&
                                            data['loveItem'][userID]
                                                ['isThanked']
                                        ? Colors.pinkAccent[400]
                                        : Colors.black,
                                    size: 18,
                                  );
                                },
                                onTap: (bool x) {
                                  return HomeScreenCubit.get(context)
                                      .interactThank(
                                    key
                                        .toString()
                                        .replaceAll(RegExp('\[<\'>\]'), '')
                                        .replaceAll(']', '')
                                        .replaceAll('[', ''),
                                  );
                                },
                                isLiked: data['loveItem'] != null &&
                                        data['loveItem'].containsKey(userID)
                                    ? data['loveItem'][userID]['isThanked']
                                    : false,
                              ),
                              Text('Thank'),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              HomeScreenCubit.get(context).showReplies(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.reply,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Reply'),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
              BlocBuilder<HomeScreenCubit, HomeScreenState>(
                builder: (context, state) {
                  if (HomeScreenCubit.get(context).isReplyShown)
                    return ReplySection(
                      postKey: newsID,
                      commentList: newsModel.replyList == null
                          ? null
                          : newsModel.replyList.values.toList(),
                    );
                  return Container();
                },
              )
            ],
          ),
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
