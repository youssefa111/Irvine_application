import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_task/helper/componants/homescreen_componants/news_container.dart';
import 'package:first_task/helper/componants/homescreen_componants/reports_container.dart';
import 'package:first_task/model/news_model.dart';
import 'package:first_task/model/report_model.dart';
import 'package:first_task/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';

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

  //================================================================

  //==================== Interact Functions ==========================

  IconData agreedIcon = FontAwesomeIcons.thumbsUp;
  IconData disagreedIcon = FontAwesomeIcons.thumbsDown;

  //==================== Agree Function ==========================

  Future<void> interactAgree(String postKey) async {
    emit(InteractedLoading());
    DocumentSnapshot instance =
        await FirebaseFirestore.instance.collection('posts').doc(postKey).get();
    Map<String, dynamic> data = instance.data() as Map<String, dynamic>;
    try {
      if (data['isLiked'] == false && data['isDisliked'] == false) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postKey)
            .update({
          'reportLikes': data['reportLikes'] + 1,
          'isLiked': true,
        });
      } else if (data['isLiked'] == false && data['isDisliked'] == true) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postKey)
            .update({
          'reportLikes': data['reportLikes'] + 1,
          'reportDislikes': data['reportDislikes'] - 1,
          'isDisliked': false,
          'isLiked': true,
        });
      } else if (data['isLiked'] == true) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postKey)
            .update({
          'reportLikes': data['reportLikes'] - 1,
          'isLiked': false,
        });
      }

      emit(InteractedSucessfully());
    } catch (error) {
      print(error.toString());
      emit(InteractedError());
    }
  }

  //==================== Disagree Function ==========================

  Future<void> interactDisagree(String postKey) async {
    emit(InteractedLoading());
    DocumentSnapshot instance =
        await FirebaseFirestore.instance.collection('posts').doc(postKey).get();
    Map<String, dynamic> data = instance.data() as Map<String, dynamic>;
    try {
      if (data['isDisliked'] == false && data['isLiked'] == false) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postKey)
            .update({
          'reportDislikes': data['reportDislikes'] + 1,
          'isDisliked': true,
        });
      } else if (data['isDisliked'] == false && data['isLiked'] == true) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postKey)
            .update({
          'reportDislikes': data['reportDislikes'] + 1,
          'reportLikes': data['reportLikes'] - 1,
          'isLiked': false,
          'isDisliked': true,
        });
      } else if (data['isDisliked'] == true) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postKey)
            .update({
          'reportDislikes': data['reportDislikes'] - 1,
          'isDisliked': false,
        });
      }

      emit(InteractedSucessfully());
    } catch (e) {
      print(e.toString());
      emit(InteractedError());
    }
  }

  //==================== Thank Function ==========================

  Future<void> interactThank(String postKey) async {
    emit(InteractedLoading());
    DocumentSnapshot instance =
        await FirebaseFirestore.instance.collection('posts').doc(postKey).get();
    Map<String, dynamic> data = instance.data() as Map<String, dynamic>;
    try {
      if (data['isThank'] == false) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postKey)
            .update({
          'newsThanks': data['newsThanks'] + 1,
          'isThank': true,
        });
      } else if (data['isThank'] == true) {
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postKey)
            .update({
          'newsThanks': data['newsThanks'] - 1,
          'isThank': false,
        });
      }

      emit(InteractedSucessfully());
    } catch (e) {
      print(e.toString());
      emit(InteractedError());
    }
  }

  //==================== Comment Function ==========================

  void comment() {}

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
