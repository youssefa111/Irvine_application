import 'package:first_task/business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommentSection extends StatefulWidget {
  final String postKey;
  dynamic commentList;
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

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.commentList == null
          ? 100.0
          : 100.0 * (widget.commentList.length + 1),
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
                    onPressed: () => HomeScreenCubit.get(context)
                        .comment(widget.postKey, commentController.text),
                    icon: Icon(
                      Icons.send,
                      color: commentController.text.trim().isEmpty
                          ? Colors.black
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          (widget.commentList == null
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
                              widget.commentList[index]['username'],
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.commentList[index]['username'],
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                    itemCount: widget.commentList.length,
                  ),
                )),
        ],
      ),
    );
  }
}
