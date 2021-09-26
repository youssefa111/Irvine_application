import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_task/helper/componants/homescreen_componants/comment_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:simple_page_indicator/simple_page_indicator.dart';
import '../../../business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import '../../../model/report_model.dart';

// ignore: must_be_immutable
class NewReportContainer extends StatefulWidget {
  final ReportModel model;
  final String reportID;

  NewReportContainer({Key? key, required this.model, required this.reportID})
      : super(key: key);

  @override
  _NewReportContainerState createState() => _NewReportContainerState();
}

class _NewReportContainerState extends State<NewReportContainer> {
  var _pageController = PageController();
  bool showComment = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userID = FirebaseAuth.instance.currentUser!.uid;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        widget.model.reporterLetter,
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
                    widget.model.reporterName,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => OptionsDialog(
                                reprotID: widget.reportID,
                              ));
                    },
                    icon: Icon(Icons.more_horiz),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  FittedBox(
                      child: Text(
                    widget.model.reportName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Spacer(),
                  Text(
                    widget.model.date,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              widget.model.reportImage != null
                  ? Container(
                      height: 260,
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                                controller: _pageController,
                                itemBuilder: (context, index) => ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        height: 245,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .9,
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              'assets/images/loading.gif',
                                          image:
                                              widget.model.reportImage![index],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                itemCount: widget.model.reportImage!.length),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SimplePageIndicator(
                            itemCount: widget.model.reportImage!.length,
                            controller: _pageController,
                            maxSize: 6,
                            minSize: 3,
                            indicatorColor: Theme.of(context).primaryColor,
                            space: 14,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 10,
                    ),
              Text(widget.model.reportContent),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(widget.reportID)
                          .snapshots(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            '( ${widget.model.reportLikes} Agrees , ${widget.model.reportDislikes} Disagrees , ${widget.model.reportComments} Comments )',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          );
                        }
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Text(
                          '( ${data['reportLikes']} Agrees , ${data['reportDislikes']} Disagrees , ${data['reportComments']} Comments )',
                          style: TextStyle(
                            fontSize: 11,
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
                    .doc(widget.reportID)
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LikeButton(
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  isLiked
                                      ? FontAwesomeIcons.solidThumbsUp
                                      : FontAwesomeIcons.thumbsUp,
                                  size: 14,
                                );
                              },
                              onTap: (bool x) {
                                return HomeScreenCubit.get(context)
                                    .interactAgree(
                                  widget.key
                                      .toString()
                                      .replaceAll(RegExp('\[<\'>\]'), '')
                                      .replaceAll(']', '')
                                      .replaceAll('[', ''),
                                );
                              },
                              isLiked: widget.model.reactItem == null ||
                                      (widget.model.reactItem != null &&
                                          !widget.model.reactItem
                                              .containsKey(userID))
                                  ? false
                                  : widget.model.reactItem[userID]['isLiked'],
                            ),
                            Text(
                              'Agree',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LikeButton(
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  isLiked
                                      ? FontAwesomeIcons.solidThumbsDown
                                      : FontAwesomeIcons.thumbsDown,
                                  size: 14,
                                );
                              },
                              onTap: (bool x) {
                                return HomeScreenCubit.get(context)
                                    .interactDisagree(
                                  widget.key
                                      .toString()
                                      .replaceAll(RegExp('\[<\'>\]'), '')
                                      .replaceAll(']', '')
                                      .replaceAll('[', ''),
                                );
                              },
                              isLiked: widget.model.reactItem == null ||
                                      (widget.model.reactItem != null &&
                                          !widget.model.reactItem
                                              .containsKey(userID))
                                  ? false
                                  : widget.model.reactItem[userID]
                                      ['isDisliked'],
                            ),
                            Text(
                              'Disagree',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              showComment = !showComment;
                            });
                          },
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                FaIcon(
                                  FontAwesomeIcons.comment,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Comment',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () => HomeScreenCubit.get(context).interactAgree(
                          widget.key
                              .toString()
                              .replaceAll(RegExp('\[<\'>\]'), '')
                              .replaceAll(']', '')
                              .replaceAll('[', ''),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LikeButton(
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  data['reactItem'] != null &&
                                          data['reactItem']
                                              .containsKey(userID) &&
                                          data['reactItem'][userID]['isLiked']
                                      ? FontAwesomeIcons.solidThumbsUp
                                      : FontAwesomeIcons.thumbsUp,
                                  color: data['reactItem'] != null &&
                                          data['reactItem']
                                              .containsKey(userID) &&
                                          data['reactItem'][userID]['isLiked']
                                      ? Colors.green
                                      : Colors.black,
                                  size: 14,
                                );
                              },
                              onTap: (bool x) {
                                return HomeScreenCubit.get(context)
                                    .interactAgree(
                                  widget.key
                                      .toString()
                                      .replaceAll(RegExp('\[<\'>\]'), '')
                                      .replaceAll(']', '')
                                      .replaceAll('[', ''),
                                );
                              },
                              isLiked: data['reactItem'] != null &&
                                      data['reactItem'].containsKey(userID)
                                  ? data['reactItem'][userID]['isLiked']
                                  : false,
                            ),
                            Text(
                              'Agree',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            HomeScreenCubit.get(context).interactDisagree(
                          widget.key
                              .toString()
                              .replaceAll(RegExp('\[<\'>\]'), '')
                              .replaceAll(']', '')
                              .replaceAll('[', ''),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LikeButton(
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  data['reactItem'] != null &&
                                          data['reactItem']
                                              .containsKey(userID) &&
                                          data['reactItem'][userID]
                                              ['isDisliked']
                                      ? FontAwesomeIcons.solidThumbsDown
                                      : FontAwesomeIcons.thumbsDown,
                                  color: data['reactItem'] != null &&
                                          data['reactItem']
                                              .containsKey(userID) &&
                                          data['reactItem'][userID]
                                              ['isDisliked']
                                      ? Colors.red[900]
                                      : Colors.black,
                                  size: 14,
                                );
                              },
                              onTap: (bool x) {
                                return HomeScreenCubit.get(context)
                                    .interactDisagree(
                                  widget.key
                                      .toString()
                                      .replaceAll(RegExp('\[<\'>\]'), '')
                                      .replaceAll(']', '')
                                      .replaceAll('[', ''),
                                );
                              },
                              isLiked: data['reactItem'] != null &&
                                      data['reactItem'].containsKey(userID)
                                  ? data['reactItem'][userID]['isDisliked']
                                  : false,
                            ),
                            Text(
                              'Disagree',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            showComment = !showComment;
                          });
                        },
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              FaIcon(
                                FontAwesomeIcons.comment,
                                size: 14,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Comment',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              BlocBuilder<HomeScreenCubit, HomeScreenState>(
                builder: (context, state) {
                  if (showComment)
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CommentSection(
                        key: ValueKey(
                          widget.key
                              .toString()
                              .replaceAll(RegExp('\[<\'>\]'), '')
                              .replaceAll(']', '')
                              .replaceAll('[', ''),
                        ),
                        postKey: widget.key
                            .toString()
                            .replaceAll(RegExp('\[<\'>\]'), '')
                            .replaceAll(']', '')
                            .replaceAll('[', ''),
                        commentList: widget.model.commentList == null
                            ? null
                            : widget.model.commentList.values.toList(),
                      ),
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

class OptionsDialog extends StatefulWidget {
  final String reprotID;
  const OptionsDialog({Key? key, required this.reprotID}) : super(key: key);

  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  int? group = 0;
  bool checkBox = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      builder: (context, state) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            height: MediaQuery.of(context).size.height * .2,
            width: MediaQuery.of(context).size.width * .2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: InteractButton(
                        func: () => HomeScreenCubit.get(context)
                          ..hidePost(widget.reprotID, context)
                          ..gethidePostsList(),
                        icon: FontAwesomeIcons.eyeSlash,
                        iconName: 'Hide post'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class InteractButton extends StatelessWidget {
  final IconData icon;
  final String iconName;
  final VoidCallback? func;

  const InteractButton({
    Key? key,
    required this.icon,
    this.func,
    required this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (InkWell(
      onTap: () => func!(),
      child: Container(
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
            Text(iconName)
          ],
        ),
      ),
    ));
  }
}
