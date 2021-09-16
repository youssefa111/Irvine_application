import 'package:first_task/business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import 'package:first_task/presentation/home_screens/home_screen.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatefulWidget {
  final String postKey;
  const CommentSection({Key? key, required this.postKey}) : super(key: key);

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
    List<String> test = [
      'hello',
      'hello World',
      'hello World',
      'hello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello hello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello Worldhello WorldWorldhello World'
    ];
    return Container(
      height: 100.0 * test.length,
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
          Expanded(
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
                        'UserName:',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        test[index],
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemCount: test.length,
            ),
          ),
        ],
      ),
    );
  }
}
