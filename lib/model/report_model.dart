import 'package:first_task/helper/constants/constants.dart';

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
  ContainerCategory containerCategory = ContainerCategory.newsContiner;

  ReportModel(
    this.reporterName,
    this.reportContent,
    this.reportImage,
    this.reportName,
    this.reportLocation,
    this.reporterLetter,
    this.reportDate,
    this.reportLikes,
    this.reportDislikes,
    this.reportComments,
  );
}
