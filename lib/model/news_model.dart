import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel {
  final String reporterName;
  final String newsTitle;
  final String newsContent;
  final String date;
  final String iconLetter;
  final int newsThanks;
  final int newsReplies;
  dynamic loveItem;
  final bool isReply;
  int containerCategory = 0;
  Timestamp timestamp;
  NewsModel({
    required this.reporterName,
    required this.newsTitle,
    required this.newsContent,
    required this.date,
    required this.iconLetter,
    required this.newsThanks,
    required this.newsReplies,
    this.containerCategory = 0,
    required this.timestamp,
    required this.isReply,
    this.loveItem,
  });

  Map<String, dynamic> toMap() {
    return {
      'reporterName': reporterName,
      'newsTitle': newsTitle,
      'newsContent': newsContent,
      'Date': date,
      'iconLetter': iconLetter,
      'newsThanks': newsThanks,
      'newsReplies': newsReplies,
      'containerCategory': containerCategory,
      'createdAt': timestamp,
      'isReply': isReply,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      reporterName: map['reporterName'],
      newsTitle: map['newsTitle'],
      newsContent: map['newsContent'],
      date: map['Date'],
      iconLetter: map['iconLetter'],
      newsThanks: map['newsThanks'],
      newsReplies: map['newsReplies'],
      containerCategory: map['containerCategory'],
      timestamp: map['createdAt'],
      isReply: map['isReply'],
      loveItem: map['loveItem'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source));
}
