import 'package:bloc/bloc.dart';
import 'package:first_task/helper/componants/homescreen_componants/news_container.dart';
import 'package:first_task/helper/componants/homescreen_componants/report_container.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  static HomeScreenCubit get(BuildContext context) => BlocProvider.of(context);

  List dataList = [
    NewsContainer(
      reporterName: 'Jas NewMn WoodBUD SouthLake',
      newsTitle: 'Natinal Law Enforcement Appreciation Day',
      newsContent:
          'I did no make it up, i watch EVERY council meeting and she stated prior to being Mayor that she wanted to defunt the Irvine Police Department. I believe it was at a council.',
      newsDate: '17 Jan',
      iconLetter: 'I',
      isAgency: false,
      newsThanks: 147,
      newsReplies: 41,
    ),
    ReportContainer(
      reporterName: 'James Wine Portota Springo',
      reportContent:
          'Hi Neighbors, Does anyone Know who i need to contact to get this grafitti removed? Location is at Bridge',
      reportImage: 'assets/grifatti.jpg',
      reportName: 'Reported Grafitti',
      reportLocation: '1.2 miles away',
      reporterLetter: 'J',
    ),
    NewsContainer(
      reporterName: 'Jas NewMn WoodBUD SouthLake',
      newsTitle: 'Natinal Law Enforcement Appreciation Day',
      newsContent:
          'I did no make it up, i watch EVERY council meeting and she stated prior to being Mayor that she wanted to defunt the Irvine Police Department. I believe it was at a council.',
      newsDate: '17 Jan',
      iconLetter: 'I',
      isAgency: false,
      newsThanks: 147,
      newsReplies: 41,
    ),
    ReportContainer(
      reporterName: 'James Wine Portota Springo',
      reportContent:
          'Hi Neighbors, Does anyone Know who i need to contact to get this grafitti removed? Location is at Bridge',
      reportImage: 'assets/grifatti.jpg',
      reportName: 'Reported Grafitti',
      reportLocation: '1.2 miles away',
      reporterLetter: 'J',
    ),
    NewsContainer(
      reporterName: 'Jas NewMn WoodBUD SouthLake',
      newsTitle: 'Natinal Law Enforcement Appreciation Day',
      newsContent:
          'I did no make it up, i watch EVERY council meeting and she stated prior to being Mayor that she wanted to defunt the Irvine Police Department. I believe it was at a council.',
      newsDate: '17 Jan',
      iconLetter: 'I',
      isAgency: false,
      newsThanks: 147,
      newsReplies: 41,
    ),
    ReportContainer(
      reporterName: 'James Wine Portota Springo',
      reportContent:
          'Hi Neighbors, Does anyone Know who i need to contact to get this grafitti removed? Location is at Bridge',
      reportImage: 'assets/grifatti.jpg',
      reportName: 'Reported Grafitti',
      reportLocation: '1.2 miles away',
      reporterLetter: 'J',
    ),
    NewsContainer(
      reporterName: 'Jas NewMn WoodBUD SouthLake',
      newsTitle: 'Natinal Law Enforcement Appreciation Day',
      newsContent:
          'I did no make it up, i watch EVERY council meeting and she stated prior to being Mayor that she wanted to defunt the Irvine Police Department. I believe it was at a council.',
      newsDate: '17 Jan',
      iconLetter: 'I',
      isAgency: false,
      newsThanks: 147,
      newsReplies: 41,
    ),
    ReportContainer(
      reporterName: 'James Wine Portota Springo',
      reportContent:
          'Hi Neighbors, Does anyone Know who i need to contact to get this grafitti removed? Location is at Bridge',
      reportImage: 'assets/grifatti.jpg',
      reportName: 'Reported Grafitti',
      reportLocation: '1.2 miles away',
      reporterLetter: 'J',
    ),
    NewsContainer(
      reporterName: 'Jas NewMn WoodBUD SouthLake',
      newsTitle: 'Natinal Law Enforcement Appreciation Day',
      newsContent:
          'I did no make it up, i watch EVERY council meeting and she stated prior to being Mayor that she wanted to defunt the Irvine Police Department. I believe it was at a council.',
      newsDate: '17 Jan',
      iconLetter: 'I',
      isAgency: false,
      newsThanks: 147,
      newsReplies: 41,
    ),
    ReportContainer(
      reporterName: 'James Wine Portota Springo',
      reportContent:
          'Hi Neighbors, Does anyone Know who i need to contact to get this grafitti removed? Location is at Bridge',
      reportImage: 'assets/grifatti.jpg',
      reportName: 'Reported Grafitti',
      reportLocation: '1.2 miles away',
      reporterLetter: 'J',
    ),
    NewsContainer(
      reporterName: 'Jas NewMn WoodBUD SouthLake',
      newsTitle: 'Natinal Law Enforcement Appreciation Day',
      newsContent:
          'I did no make it up, i watch EVERY council meeting and she stated prior to being Mayor that she wanted to defunt the Irvine Police Department. I believe it was at a council.',
      newsDate: '17 Jan',
      iconLetter: 'I',
      isAgency: false,
      newsThanks: 147,
      newsReplies: 41,
    ),
    ReportContainer(
      reporterName: 'James Wine Portota Springo',
      reportContent:
          'Hi Neighbors, Does anyone Know who i need to contact to get this grafitti removed? Location is at Bridge',
      reportImage: 'assets/grifatti.jpg',
      reportName: 'Reported Grafitti',
      reportLocation: '1.2 miles away',
      reporterLetter: 'J',
    ),
    NewsContainer(
      reporterName: 'Jas NewMn WoodBUD SouthLake',
      newsTitle: 'Natinal Law Enforcement Appreciation Day',
      newsContent:
          'I did no make it up, i watch EVERY council meeting and she stated prior to being Mayor that she wanted to defunt the Irvine Police Department. I believe it was at a council.',
      newsDate: '17 Jan',
      iconLetter: 'I',
      isAgency: false,
      newsThanks: 147,
      newsReplies: 41,
    ),
    ReportContainer(
      reporterName: 'James Wine Portota Springo',
      reportContent:
          'Hi Neighbors, Does anyone Know who i need to contact to get this grafitti removed? Location is at Bridge',
      reportImage: 'assets/grifatti.jpg',
      reportName: 'Reported Grafitti',
      reportLocation: '1.2 miles away',
      reporterLetter: 'J',
    ),
    NewsContainer(
      reporterName: 'Jas NewMn WoodBUD SouthLake',
      newsTitle: 'Natinal Law Enforcement Appreciation Day',
      newsContent:
          'I did no make it up, i watch EVERY council meeting and she stated prior to being Mayor that she wanted to defunt the Irvine Police Department. I believe it was at a council.',
      newsDate: '17 Jan',
      iconLetter: 'I',
      isAgency: false,
      newsThanks: 147,
      newsReplies: 41,
    ),
    ReportContainer(
      reporterName: 'James Wine Portota Springo',
      reportContent:
          'Hi Neighbors, Does anyone Know who i need to contact to get this grafitti removed? Location is at Bridge',
      reportImage: 'assets/grifatti.jpg',
      reportName: 'Reported Grafitti',
      reportLocation: '1.2 miles away',
      reporterLetter: 'J',
    ),
    NewsContainer(
      reporterName: 'Jas NewMn WoodBUD SouthLake',
      newsTitle: 'Natinal Law Enforcement Appreciation Day',
      newsContent:
          'I did no make it up, i watch EVERY council meeting and she stated prior to being Mayor that she wanted to defunt the Irvine Police Department. I believe it was at a council.',
      newsDate: '17 Jan',
      iconLetter: 'I',
      isAgency: false,
      newsThanks: 147,
      newsReplies: 41,
    ),
    ReportContainer(
      reporterName: 'James Wine Portota Springo',
      reportContent:
          'Hi Neighbors, Does anyone Know who i need to contact to get this grafitti removed? Location is at Bridge',
      reportImage: 'assets/grifatti.jpg',
      reportName: 'Reported Grafitti',
      reportLocation: '1.2 miles away',
      reporterLetter: 'J',
    ),
  ];

  void getHomeData() {
    emit(HomeScreenLoading());
    dataList = dataList;

    emit(HomeScreenSucess());
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
