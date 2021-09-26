// ignore: must_be_immutable
import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath;
  final String title;
  final Widget widget;

  const TopContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.imagePath,
    required this.title,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => widget)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                imagePath,
                width: width,
                height: height * .6,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 5,
              ),
              FittedBox(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopSearchBar extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  TopSearchBar({Key? key, required this.text, required this.onChanged})
      : super(key: key);

  @override
  _TopSearchBarState createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: controller.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: 'Search',
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
