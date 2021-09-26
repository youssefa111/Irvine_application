import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../model/news_model.dart';
import '../../../../model/report_model.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddInitial());

  static AddCubit get(BuildContext context) => BlocProvider.of(context);

  List homePostsList = [];
  int i = 0;
  List mediaLinksList = [];
  Future<void> addReport({
    required ReportModel reportModel,
  }) async {
    emit(AddReportLoading());
    try {
      var instance = await FirebaseFirestore.instance
          .collection("posts")
          .add(reportModel.toMap());

      print(instance.id);
      if (imagesList.isNotEmpty) {
        while (i < imagesList.length) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('reports')
              .child(instance.id)
              .child('media${i + 1}');
          await ref.putFile(imagesList[i]);
          final url = await ref.getDownloadURL();
          mediaLinksList.add(url);
          i++;
        }
        await instance.update({
          'mediaList': FieldValue.arrayUnion(mediaLinksList),
        });
      }
      emit(AddReportSucessfully());
    } catch (e) {
      print(e.toString());
      emit(AddReportError());
    }
  }

  // ignore: avoid_init_to_null
  File? image = null;
  List<File> imagesList = [];
  final picker = ImagePicker();
  Future<void> getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(ImageAddedSucessfully());
      imagesList.add(image!);
    } else {
      print('No image selected.');
    }
  }

  void removeImage(int index) {
    imagesList.removeAt(index);
    emit(ImageRemovedSucessfully());
  }

  Future<dynamic> getUserData() async {
    var userID = FirebaseAuth.instance.currentUser!.uid;
    var userInfo =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();

    return userInfo;
  }

  Future<void> addNews({
    required NewsModel newsModel,
  }) async {
    emit(AddNewsLoading());
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .add(newsModel.toMap());

      emit(AddNewsSucessfully());
    } catch (e) {
      print(e.toString());
      emit(AddNewsError());
    }
  }
}
