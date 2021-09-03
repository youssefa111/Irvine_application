import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ReportScreen extends StatefulWidget {
  final IconData iconData;
  final String reportCategoryName;

  ReportScreen(
      {Key? key, required this.iconData, required this.reportCategoryName})
      : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  File? _image = null;
  final picker = ImagePicker();
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Report an issue'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'For Emergencies Call 911',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Icon(widget.iconData),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.reportCategoryName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: 'Enter Issue Description...',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Incident Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text('100 Main Street irvine'),
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
              _image == null
                  ? InkWell(
                      onTap: getImageFromGallery,
                      child: Container(
                          child: Center(
                        child: Column(children: <Widget>[
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
                    )
                  : Center(
                      child: Container(
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
