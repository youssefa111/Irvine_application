import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_task/business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../business_logic/cubit/add_process_cubit/cubit/add_cubit.dart';
import '../../helper/constants/constants.dart';
import '../../model/report_model.dart';

class ReportScreen extends StatefulWidget {
  final String iconData;
  final String reportCategoryName;

  ReportScreen(
      {Key? key, required this.iconData, required this.reportCategoryName})
      : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  var reportTextEditing = TextEditingController();
  var scrollController = ScrollController();
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    reportTextEditing.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userData = HomeScreenCubit.get(context).userData;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd").format(now);
    return BlocProvider(
      create: (context) => AddCubit(),
      child: BlocConsumer<AddCubit, AddState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: linearGradient,
                  ),
                ),
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    AddCubit.get(context).imagesList = [];
                    AddCubit.get(context).image = null;
                    Navigator.of(context).pop();
                  },
                ),
                centerTitle: true,
                title: Text(
                  'Report an issue',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      !formKey.currentState!.validate()
                          // ignore: unnecessary_statements
                          ? null
                          : AddCubit.get(context)
                              .addReport(
                                reportModel: ReportModel(
                                  date: formattedDate,
                                  reporterName: userData.name,
                                  reportContent: reportTextEditing.text,
                                  reportName: widget.reportCategoryName,
                                  reportLocation: userData.neighborhood,
                                  reporterLetter: userData.name[0],
                                  reportComments: 0,
                                  reportDislikes: 0,
                                  reportLikes: 0,
                                  userID:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  containerCategory: 1,
                                  timestamp: Timestamp.now(),
                                ),
                              )
                              .then((value) {
                                Navigator.of(context).pop();
                                Future.delayed(Duration(seconds: 1));
                              })
                              .then((value) =>
                                  HomeScreenCubit.get(context).changeBottom(0))
                              .then(
                                (value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                        'The Report is added Sucessfully!'),
                                    backgroundColor: Colors.green,
                                  ),
                                ),
                              );
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              body: (state) is AddReportLoading
                  ? Center(
                      child: DefaultTextStyle(
                        style: const TextStyle(
                            fontSize: 25.0, color: Colors.black),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('Uploading...'),
                          ],
                          isRepeatingAnimation: true,
                          repeatForever: true,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'For Emergencies Call 911',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset(widget.iconData),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    widget.reportCategoryName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Scrollbar(
                                thickness: 10,
                                controller: scrollController,
                                child: TextFormField(
                                  scrollController: scrollController,
                                  scrollPhysics: ScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  validator: (String? valid) {
                                    if (valid!.isEmpty) {
                                      return 'Please Enter Description for thew report post!';
                                    }
                                  },
                                  keyboardType: TextInputType.multiline,
                                  controller: reportTextEditing,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(fontSize: 12),
                                      hintText: 'Enter Issue Description...',
                                      border: OutlineInputBorder()),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Incident Location',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(userData.neighborhood),
                                  Spacer(),
                                  IconButton(
                                    iconSize: 45,
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.arrow_right,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<AddCubit, AddState>(
                                  builder: (context, state) {
                                var bloc = AddCubit.get(context);
                                if (bloc.imagesList.isEmpty) {
                                  return InkWell(
                                    onTap: bloc.getImageFromGallery,
                                    child: Container(
                                        child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            FaIcon(
                                              FontAwesomeIcons.camera,
                                              color: Colors.grey[400],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text('Add photos and vidoes'),
                                          ]),
                                    )),
                                  );
                                } else {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: bloc.imagesList.map((e) {
                                          if (e == bloc.imagesList.last &&
                                              bloc.imagesList.length < 3) {
                                            return Wrap(
                                              children: <Widget>[
                                                ImageContainer(
                                                  e: e,
                                                  index: bloc.imagesList
                                                      .indexOf(e),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(),
                                                  ),
                                                  child: Center(
                                                    child: IconButton(
                                                      onPressed: bloc
                                                          .getImageFromGallery,
                                                      icon: Icon(Icons.add),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                          return ImageContainer(
                                            e: e,
                                            index: bloc.imagesList.indexOf(e),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  );
                                }
                              })
                            ],
                          ),
                        ),
                      ),
                    ));
        },
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final e;
  final index;

  const ImageContainer({Key? key, this.e, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCubit, AddState>(
      builder: (context, state) {
        return Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(border: Border.all()),
          child: Stack(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(border: Border.all()),
                child: Image.file(
                  e,
                  fit: BoxFit.fill,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                widthFactor: 0.9,
                child: IconButton(
                  onPressed: () {
                    AddCubit.get(context).removeImage(index);
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.timesCircle,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
