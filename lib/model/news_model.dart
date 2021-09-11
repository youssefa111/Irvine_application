import 'dart:convert';

class NewsModel {
  final String reporterName;
  final String newsTitle;
  final String newsContent;
  final String newsDate;
  final String iconLetter;
  final int newsThanks;
  final int newsReplies;
  int containerCategory = 0;
  NewsModel({
    required this.reporterName,
    required this.newsTitle,
    required this.newsContent,
    required this.newsDate,
    required this.iconLetter,
    required this.newsThanks,
    required this.newsReplies,
    this.containerCategory = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'reporterName': reporterName,
      'newsTitle': newsTitle,
      'newsContent': newsContent,
      'newsDate': newsDate,
      'iconLetter': iconLetter,
      'newsThanks': newsThanks,
      'newsReplies': newsReplies,
      'containerCategory': containerCategory,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
        reporterName: map['reporterName'],
        newsTitle: map['newsTitle'],
        newsContent: map['newsContent'],
        newsDate: map['newsDate'],
        iconLetter: map['iconLetter'],
        newsThanks: map['newsThanks'],
        newsReplies: map['newsReplies'],
        containerCategory: map['containerCategory']);
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source));
}
