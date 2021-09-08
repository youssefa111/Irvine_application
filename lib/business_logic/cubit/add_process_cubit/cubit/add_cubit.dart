import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_state.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddInitial());

  static AddCubit get(BuildContext context) => BlocProvider.of(context);

  List homePostsList = [];

  void addReport() {
    emit(AddReportLoading());
    FirebaseFirestore.instance.collection("posts").add({
      'h': 'h',
      "ss": 12,
    });
  }

  // ignore: avoid_init_to_null
  File? image = null;
  List imagesList = [];
  final picker = ImagePicker();
  // Future getImageFromGallery() async {
  //   final pickedFile = await picker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (pickedFile != null) {
  //     image = File(pickedFile.path);
  //     emit(MediaAddedSucessfully());
  //     imagesList.add(image);
  //   } else {
  //     print('No image selected.');
  //   }
  // }

  // ignore: non_constant_identifier_names
  // Future<void> addReport(NewReportContainer newReportContiner) async {
  //   dataList.insert(0, newReportContiner);

  //   emit(ReportAddedSucessfully());
  // }

  void removeImage(int index) {
    imagesList.removeAt(index);
    emit(ImageRemovedSucessfully());
  }
}
