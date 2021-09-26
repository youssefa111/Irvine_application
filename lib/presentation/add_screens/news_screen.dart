import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_task/business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../business_logic/cubit/add_process_cubit/cubit/add_cubit.dart';
import '../../helper/constants/constants.dart';
import '../../model/news_model.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  var newsTextEditing = TextEditingController();
  var titleTextEditing = TextEditingController();
  var scrollController = ScrollController();
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    newsTextEditing.dispose();
    titleTextEditing.dispose();
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
                  HomeScreenCubit.get(context).changeBottom(0);
                },
              ),
              centerTitle: true,
              title: Text(
                'Add News',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    !formKey.currentState!.validate()
                        // ignore: unnecessary_statements
                        ? null
                        : AddCubit.get(context)
                            .addNews(
                              newsModel: NewsModel(
                                reporterName: userData.name,
                                newsTitle: titleTextEditing.text,
                                newsContent: newsTextEditing.text,
                                date: formattedDate,
                                iconLetter: userData.name.toString()[0],
                                newsThanks: 0,
                                newsReplies: 0,
                                timestamp: Timestamp.now(),
                                isReply: false,
                              ),
                            )
                            .then((value) =>
                                HomeScreenCubit.get(context).changeBottom(0))
                            .then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 2),
                                  content:
                                      Text('The News is added Sucessfully!'),
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            );
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            body: (state) is AddNewsLoading
                ? Center(
                    child: DefaultTextStyle(
                      style:
                          const TextStyle(fontSize: 25.0, color: Colors.black),
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
                              Text(
                                'Title',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                maxLength: 100,
                                controller: titleTextEditing,
                                decoration: InputDecoration(
                                  hintText: 'Enter News Title...',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (String? valid) {
                                  if (valid!.isEmpty) {
                                    return 'Please Enter Title for thew news post!';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
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
                                  controller: newsTextEditing,
                                  maxLines: 5,
                                  maxLength: 200,
                                  decoration: InputDecoration(
                                      hintText: 'Enter News Description...',
                                      border: OutlineInputBorder()),
                                  validator: (String? valid) {
                                    if (valid!.isEmpty) {
                                      return 'Please Enter Description for thew news post!';
                                    }
                                  },
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
