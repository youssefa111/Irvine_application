import 'dart:convert';

class ReportModel {
  String reporterName;
  String reportContent;
  List<dynamic> reportImage;
  String reportName;
  String reportLocation;
  String reporterLetter;
  String reportDate;
  int reportLikes;
  int reportDislikes;
  int reportComments;
  int containerCategory = 1;
  String userID;

  ReportModel({
    required this.reporterName,
    required this.reportContent,
    required this.reportImage,
    required this.reportName,
    required this.reportLocation,
    required this.reporterLetter,
    required this.reportDate,
    required this.reportLikes,
    required this.reportDislikes,
    required this.reportComments,
    required this.containerCategory,
    required this.userID,
  });

  Map<String, dynamic> toMap() {
    return {
      'reporterName': reporterName,
      'reportContent': reportContent,
      'reportImage': reportImage,
      'reportName': reportName,
      'reportLocation': reportLocation,
      'reporterLetter': reporterLetter,
      'reportDate': reportDate,
      'reportLikes': reportLikes,
      'reportDislikes': reportDislikes,
      'reportComments': reportComments,
      'containerCategory': containerCategory,
      'userID': userID,
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      reporterName: map['reporterName'],
      reportContent: map['reportContent'],
      reportImage: List<dynamic>.from(map['reportImage']),
      reportName: map['reportName'],
      reportLocation: map['reportLocation'],
      reporterLetter: map['reporterLetter'],
      reportDate: map['reportDate'],
      reportLikes: map['reportLikes'],
      reportDislikes: map['reportDislikes'],
      reportComments: map['reportComments'],
      containerCategory: map['containerCategory'],
      userID: map['userID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) =>
      ReportModel.fromMap(json.decode(source));
}
