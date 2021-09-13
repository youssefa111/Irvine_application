import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_task/business_logic/cubit/add_process_cubit/cubit/add_cubit.dart';
import 'package:first_task/helper/constants/constants.dart';
import 'package:first_task/model/news_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  var newsTextEditing = TextEditingController();
  var titleTextEditing = TextEditingController();
  var userInfo;
  var userID;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userID = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  void dispose() {
    newsTextEditing.dispose();
    titleTextEditing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                reporterName: userInfo['name'],
                                newsTitle: titleTextEditing.text,
                                newsContent: newsTextEditing.text,
                                date: formattedDate,
                                iconLetter: userInfo['name'].toString()[0],
                                newsThanks: 0,
                                newsReplies: 0,
                                timestamp: Timestamp.now(),
                                isReply: false,
                                isThank: false,
                              ),
                            )
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
                            )
                            .then((value) {
                            Future.delayed(Duration(seconds: 3)).then((value) {
                              Navigator.pop(context);
                            });
                          });
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            body: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userID)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    userInfo = data;
                    return Padding(
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
                                TextFormField(
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
                              ]),
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('Something went wrong'));
                  }
                }),
          );
        },
      ),
    );
  }
}
