import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_task/helper/componants/homescreen_componants/news_container.dart';
import 'package:first_task/helper/componants/homescreen_componants/reports_container.dart';
import 'package:first_task/model/news_model.dart';
import 'package:first_task/model/report_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  static HomeScreenCubit get(BuildContext context) => BlocProvider.of(context);

  List dataList = [];

  Future<void> getHomeData() async {
    emit(HomeScreenLoading());
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("posts").get();
      querySnapshot.docs.map((e) {
        var index = dataList.indexOf(e);
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        if (data['containerCategory'] == 0) {
          dataList.add(NewsContainer(
            newsModel: NewsModel.fromMap(data),
            key: ObjectKey("key$index"),
          ));
        } else if (data['containerCategory'] == 1) {
          dataList.add(
            NewReportContainer(
              model: ReportModel.fromMap(data),
              key: ObjectKey("key$index"),
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

  var filterList = [];

  void filterHome(int index) {
    if (index == 1) {
      filterList = dataList;

      print(filterList);
      emit(HomeScreenSucess());
    } else if (index == 2) {
      filterList = dataList
          .where((element) =>
              element.toString() == "ReportContainer" ||
              element.toString() == "NewReportContainer")
          .toList();

      print(filterList);
      emit(FilteredSucessfully());
    } else if (index == 3) {
      filterList = dataList
          .where((element) => element.toString() == "NewsContainer")
          .toList();

      print(filterList);
      emit(FilteredSucessfully());
    } else {
      return;
    }
  }

  bool isAgree = false;
  bool isDisagree = false;
  IconData agreedIcon = FontAwesomeIcons.thumbsUp;
  IconData disagreedIcon = FontAwesomeIcons.thumbsDown;
  void interactAgree() {
    isAgree = !isAgree;
    agreedIcon =
        isAgree ? FontAwesomeIcons.solidThumbsUp : FontAwesomeIcons.thumbsUp;
    if (disagreedIcon == FontAwesomeIcons.solidThumbsDown) {
      disagreedIcon = FontAwesomeIcons.thumbsDown;
      isDisagree = false;
    }
    emit(InteractedSucessfully());
  }

  void interactDisagree() {
    isDisagree = !isDisagree;
    disagreedIcon = isDisagree
        ? FontAwesomeIcons.solidThumbsDown
        : FontAwesomeIcons.thumbsDown;

    if (agreedIcon == FontAwesomeIcons.solidThumbsUp) {
      agreedIcon = FontAwesomeIcons.thumbsUp;
      isAgree = false;
    }
    emit(InteractedSucessfully());
  }

  void comment() {}
  void share() {}

  var searchList = [];
  void search(String text) {}
}
