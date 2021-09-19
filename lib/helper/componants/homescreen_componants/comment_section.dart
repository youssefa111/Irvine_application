import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_task/business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class CommentSection extends StatefulWidget {
  final String postKey;
  List? commentList;
  CommentSection({
    Key? key,
    required this.postKey,
    this.commentList,
  }) : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  var commentController = TextEditingController();
  String _x = '';

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postKey)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: widget.commentList == null
                ? 120.0
                : 100.0 * (widget.commentList!.length + .5),
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: 'Write a Comment...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                gapPadding: 12,
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            commentController.text.trim().isEmpty
                                ? null
                                : HomeScreenCubit.get(context)
                                    .comment(
                                        widget.postKey, commentController.text)
                                    .then((value) => commentController.clear());
                          },
                          icon: Icon(
                            Icons.send,
                            color: HexColor("#4BB9BC"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.commentList == null
                    ? Text('There is no Comment yet!')
                    : Expanded(
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.commentList![index].split(':')[0],
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.commentList![index].split(':')[1],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: widget.commentList!.length,
                        ),
                      ),
              ],
            ),
          );
        }
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        List? x = data['commentList']?.values.toList();
        return Container(
          height: x == null ? 120.0 : 100.0 * (x.length + .5),
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Write a Comment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              gapPadding: 12,
                            ),
                            fillColor: Colors.grey[200],
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          commentController.text.trim().isEmpty
                              ? null
                              : HomeScreenCubit.get(context)
                                  .comment(
                                      widget.postKey, commentController.text)
                                  .then((value) => commentController.clear());
                        },
                        icon: Icon(
                          Icons.send,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              x == null
                  ? Text('There is no Comment yet!')
                  : Expanded(
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  x[index].split(':')[0],
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  x[index].split(':')[1],
                                ),
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: x.length,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
