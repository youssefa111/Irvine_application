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
  bool isComment;
  dynamic reactItem;
  dynamic commentList;

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
    required this.isComment,
    this.reactItem,
    this.commentList,
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
      'isComment': isComment,
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
        isComment: map['isComment'],
        reactItem: map['reactItem'],
        commentList: map['commenList']);
  }
}
