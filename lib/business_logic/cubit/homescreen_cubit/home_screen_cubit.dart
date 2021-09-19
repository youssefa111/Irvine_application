import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helper/componants/homescreen_componants/news_container.dart';
import '../../../helper/componants/homescreen_componants/reports_container.dart';
import '../../../model/news_model.dart';
import '../../../model/report_model.dart';
import '../../../model/user_model.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  static HomeScreenCubit get(BuildContext context) => BlocProvider.of(context);

  //==================== HomeData Function ==========================
  List dataList = [];

  Future<void> getHomeData() async {
    dataList = [];
    emit(HomeScreenLoading());
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("posts")
          .orderBy('createdAt', descending: true)
          .get();
      querySnapshot.docs.map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        if (data['containerCategory'] == 0) {
          dataList.add(NewsContainer(
            newsModel: NewsModel.fromMap(data),
            newsID: e.id,
            key: ValueKey(e.id),
          ));
        } else if (data['containerCategory'] == 1) {
          dataList.add(
            NewReportContainer(
              model: ReportModel.fromMap(data),
              reportID: e.id,
              key: ValueKey(e.id),
            ),
          );
        }
      }).toList();

      emit(HomeScreenSucess());
    } catch (e) {
      print(e.toString());
      emit(HomeScreenError());
    }
  }

  //====================== UserData Function ====================================

  late UserModel userData;

  Future<UserModel> userDataLoad() async {
    var result = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return userData = UserModel.fromMap(result.data() as Map<String, dynamic>);
  }
  //================================================================

  //==================== Filter Function ==========================

  var filterList = [];

  void filterHome(int index) {
    if (index == 1) {
      filterList = [...dataList];

      emit(HomeScreenSucess());
    } else if (index == 2) {
      filterList = dataList
          .where((element) => element.toString().contains('NewReportContainer'))
          .toList();

      emit(FilteredSucessfully());
    } else if (index == 3) {
      filterList = dataList
          .where((element) => element.toString().contains('NewsContainer'))
          .toList();

      emit(FilteredSucessfully());
    } else {
      return;
    }
  }

  //=================================================================

  bool isLikedFlag = false;
  Future<bool?> interactAgree(String postKey) async {
    emit(InteractedLoading());
    var userID = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot instance =
        await FirebaseFirestore.instance.collection('posts').doc(postKey).get();
    Map<String, dynamic> data = instance.data() as Map<String, dynamic>;
    var reactItem = data['reactItem'];
    var isLiked = reactItem != null && reactItem.containsKey(userID)
        ? reactItem[userID]['isLiked']
        : null;
    var isDisliked = reactItem != null && reactItem.containsKey(userID)
        ? reactItem[userID]['isDisliked']
        : null;
    bool isLikedFlag = isLiked != null ? isLiked : false;
    try {
      if (reactItem == null || isLiked == null || isDisliked == null) {
        await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
          {
            'reportLikes': data['reportLikes'] + 1,
            'reactItem': {
              userID: {
                'isLiked': true,
                'isDisliked': false,
              },
            }
          },
          SetOptions(merge: true),
        );
      } else {
        if (isLiked == false && isDisliked == false) {
          await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
            {
              'reportLikes': data['reportLikes'] + 1,
              'reactItem': {
                userID: {
                  'isLiked': true,
                  'isDisliked': false,
                },
              }
            },
            SetOptions(merge: true),
          );
        } else if (isLiked == false && isDisliked == true) {
          await FirebaseFirestore.instance
              .collection('posts')
              .doc(postKey)
              .update({
            'reportLikes': data['reportLikes'] + 1,
            'reportDislikes': data['reportDislikes'] - 1,
            'reactItem': {
              userID: {
                'isLiked': true,
                'isDisliked': false,
              },
            }
          });
        } else if (isLiked == true) {
          await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
            {
              'reportLikes': data['reportLikes'] - 1,
              'reactItem': {
                userID: {
                  'isLiked': false,
                  'isDisliked': false,
                },
              }
            },
            SetOptions(merge: true),
          );
        }
      }

      emit(InteractedSucessfully());
      return !isLikedFlag;
    } catch (error) {
      print(error.toString());
      emit(InteractedError());
      return isLikedFlag;
    }
  }

  //==================== Disagree Function ==========================

  bool isDislikedFlag = false;

  Future<bool> interactDisagree(String postKey) async {
    print(postKey);
    emit(InteractedLoading());
    var userID = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot instance =
        await FirebaseFirestore.instance.collection('posts').doc(postKey).get();
    Map<String, dynamic> data = instance.data() as Map<String, dynamic>;
    var reactItem = data['reactItem'];
    var isLiked = reactItem != null && reactItem.containsKey(userID)
        ? reactItem[userID]['isLiked']
        : null;
    var isDisliked = reactItem != null && reactItem.containsKey(userID)
        ? reactItem[userID]['isDisliked']
        : null;
    bool isDislikedFlag = isDisliked != null ? isDisliked : false;
    try {
      if (reactItem == null || isLiked == null || isDisliked == null) {
        await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
          {
            'reportDislikes': data['reportDislikes'] + 1,
            'reactItem': {
              userID: {
                'isLiked': false,
                'isDisliked': true,
              },
            }
          },
          SetOptions(merge: true),
        );
      } else {
        if (isLiked == false && isDisliked == false) {
          await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
            {
              'reportDislikes': data['reportDislikes'] + 1,
              'reactItem': {
                userID: {
                  'isDisliked': true,
                  'isLiked': false,
                },
              }
            },
            SetOptions(merge: true),
          );
        } else if (isDisliked == false && isLiked == true) {
          await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
            {
              'reportDislikes': data['reportDislikes'] + 1,
              'reportLikes': data['reportLikes'] - 1,
              'reactItem': {
                userID: {
                  'isDisliked': true,
                  'isLiked': false,
                },
              }
            },
            SetOptions(merge: true),
          );
        } else if (isDisliked == true) {
          await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
            {
              'reportDislikes': data['reportDislikes'] - 1,
              'reactItem': {
                userID: {
                  'isLiked': false,
                  'isDisliked': false,
                },
              }
            },
            SetOptions(merge: true),
          );
        }
      }

      emit(InteractedSucessfully());
      return !isDislikedFlag;
    } catch (e) {
      print(e.toString());
      emit(InteractedError());
      return isDislikedFlag;
    }
  }

  //==================== Thank Function ==========================

  bool isThankedFlag = false;

  Future<bool> interactThank(String postKey) async {
    emit(InteractedLoading());
    var userID = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot instance =
        await FirebaseFirestore.instance.collection('posts').doc(postKey).get();
    Map<String, dynamic> data = instance.data() as Map<String, dynamic>;
    var loveItem = data['loveItem'];
    var isThanked = loveItem != null && loveItem.containsKey(userID)
        ? loveItem[userID]['isThanked']
        : null;
    bool isThankedFlag = isThanked != null ? isThanked : false;

    try {
      if (loveItem == null || isThanked == null) {
        await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
          {
            'newsThanks': data['newsThanks'] + 1,
            'loveItem': {
              userID: {
                'isThanked': true,
              }
            }
          },
          SetOptions(merge: true),
        );
      } else {
        if (isThanked == false) {
          await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
            {
              'newsThanks': data['newsThanks'] + 1,
              'loveItem': {
                userID: {
                  'isThanked': true,
                }
              }
            },
            SetOptions(merge: true),
          );
        } else if (isThanked == true) {
          await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
            {
              'newsThanks': data['newsThanks'] - 1,
              'loveItem': {
                userID: {
                  'isThanked': false,
                }
              }
            },
            SetOptions(merge: true),
          );
        }
      }

      emit(InteractedSucessfully());
      return !isThankedFlag;
    } catch (e) {
      print(e.toString());
      emit(InteractedError());
      return isThankedFlag;
    }
  }

  //==================== Comment Function ==========================

  Future<void> comment(String postKey, String comment) async {
    emit(CommentLoading());
    try {
      var userID = FirebaseAuth.instance.currentUser!.uid;
      var userInstance = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get();
      Map<String, dynamic> userData =
          userInstance.data() as Map<String, dynamic>;
      DocumentSnapshot instance = await FirebaseFirestore.instance
          .collection('posts')
          .doc(postKey)
          .get();
      Map<String, dynamic> data = instance.data() as Map<String, dynamic>;
      var commentList = data['commentList'];
      if (commentList == null) {
        await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
          {
            'reportComments': data['reportComments'] + 1,
            'commentList': {
              Timestamp.now().toString(): userData['name'] + ':' + comment,
            },
          },
          SetOptions(merge: true),
        );
      } else {
        await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
          {
            'reportComments': data['reportComments'] + 1,
            'commentList': {
              Timestamp.now().toString(): userData['name'] + ':' + comment,
            },
          },
          SetOptions(
            merge: true,
          ),
        );
      }
      emit(CommentSucessfully());
    } catch (e) {
      print(e.toString());
      emit(CommentError());
    }
  }

  //================================================================

  //====================== Show Comment Function ===================

  bool isCommentShown = false;

  void showComment() {
    isCommentShown = !isCommentShown;
    emit(ShowComment());
  }

  //================================================================

  //==================== Reply Function ==========================

  Future<void> reply(String postKey, String reply) async {
    emit(ReplyLoading());
    try {
      var userID = FirebaseAuth.instance.currentUser!.uid;
      var userInstance = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get();
      Map<String, dynamic> userData =
          userInstance.data() as Map<String, dynamic>;
      DocumentSnapshot instance = await FirebaseFirestore.instance
          .collection('posts')
          .doc(postKey)
          .get();
      Map<String, dynamic> data = instance.data() as Map<String, dynamic>;
      var replyList = data['replyList'];
      if (replyList == null) {
        await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
          {
            'newsReplies': data['newsReplies'] + 1,
            'replyList': {
              Timestamp.now().toString(): userData['name'] + ':' + reply,
            },
          },
          SetOptions(merge: true),
        );
      } else {
        await FirebaseFirestore.instance.collection('posts').doc(postKey).set(
          {
            'newsReplies': data['newsReplies'] + 1,
            'replyList': {
              Timestamp.now().toString(): userData['name'] + ':' + reply,
            },
          },
          SetOptions(
            merge: true,
          ),
        );
      }
      emit(ReplySucessfully());
    } catch (e) {
      print(e.toString());
      emit(ReplyError());
    }
  }

  //================================================================

  //====================== Show Replys Function ===================

  bool isReplyShown = false;

  void showReplies() {
    isReplyShown = !isReplyShown;
    emit(ShowReply());
  }

  //================================================================

  //==================== Search Function ==========================
  var searchList = [];
  void search(String text) {}

  //================================================================

  //==================== Options Function ==========================
  void hidePost(String key, BuildContext context) {
    dataList.removeWhere((element) => element.toString().contains(key));
    Navigator.pop(context);
    emit(OptionsSucessfully());
  }

  //================================================================
}
