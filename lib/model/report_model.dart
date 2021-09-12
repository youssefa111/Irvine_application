import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  String reporterName;
  String reportContent;
  List<dynamic>? reportImage;
  String reportName;
  String reportLocation;
  String reporterLetter;
  String date;
  int reportLikes;
  int reportDislikes;
  int reportComments;
  int containerCategory = 1;
  String userID;
  Timestamp timestamp;
  bool isLiked;
  bool isDisliked;
  bool isComment;

  ReportModel({
    required this.reporterName,
    required this.reportContent,
    this.reportImage,
    required this.reportName,
    required this.reportLocation,
    required this.reporterLetter,
    required this.date,
    required this.reportLikes,
    required this.reportDislikes,
    required this.reportComments,
    required this.containerCategory,
    required this.userID,
    required this.timestamp,
    required this.isLiked,
    required this.isDisliked,
    required this.isComment,
  });

  Map<String, dynamic> toMap() {
    return {
      'reporterName': reporterName,
      'reportContent': reportContent,
      'reportName': reportName,
      'reportImage': reportImage,
      'reportLocation': reportLocation,
      'reporterLetter': reporterLetter,
      'Date': date,
      'reportLikes': reportLikes,
      'reportDislikes': reportDislikes,
      'reportComments': reportComments,
      'containerCategory': containerCategory,
      'userID': userID,
      'createdAt': timestamp,
      'isLiked': isLiked,
      'isComment': isComment,
      'isDisliked': isDisliked,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      reporterName: map['reporterName'],
      reportContent: map['reportContent'],
      reportName: map['reportName'],
      reportLocation: map['reportLocation'],
      reporterLetter: map['reporterLetter'],
      date: map['Date'],
      reportLikes: map['reportLikes'],
      reportDislikes: map['reportDislikes'],
      reportComments: map['reportComments'],
      containerCategory: map['containerCategory'],
      userID: map['userID'],
      reportImage: map['mediaList'],
      timestamp: map['createdAt'],
      isLiked: map['isLiked'],
      isDisliked: map['isDisliked'],
      isComment: map['isComment'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) =>
      ReportModel.fromMap(json.decode(source));
}
