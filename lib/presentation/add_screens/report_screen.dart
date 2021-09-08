import 'package:first_task/business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import 'package:first_task/helper/componants/homescreen_componants/new_report_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  var reportTextEditing = TextEditingController();

  @override
  void dispose() {
    reportTextEditing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                HomeScreenCubit.get(context).imagesList = [];
                HomeScreenCubit.get(context).image = null;
                Navigator.of(context).pop();
              },
            );
          },
        ),
        centerTitle: true,
        title: Text('Report an issue'),
        actions: [
          TextButton(
            onPressed: () {
              reportTextEditing.text.isEmpty
                  // ignore: unnecessary_statements
                  ? null
                  : HomeScreenCubit.get(context)
                      .addReport(NewReportContainer(
                          reporterName: 'youssef hussien',
                          reportContent: reportTextEditing.text,
                          reportImage: HomeScreenCubit.get(context).imagesList,
                          reportName: widget.reportCategoryName,
                          reportLocation: '100 Main Street Lrvine',
                          reporterLetter: 'Y'))
                      .then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text('The Report is added Sucessfully!'),
                            backgroundColor: Colors.green,
                          ),
                        ),
                      )
                      .then((value) {
                      Future.delayed(Duration(seconds: 3)).then((value) {
                        Navigator.pop(context);
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
                controller: reportTextEditing,
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
              BlocBuilder<HomeScreenCubit, HomeScreenState>(
                  builder: (context, state) {
                var bloc = HomeScreenCubit.get(context);
                if (bloc.imagesList.isEmpty) {
                  return InkWell(
                    onTap: bloc.getImageFromGallery,
                    child: Container(
                        child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: bloc.imagesList.map((e) {
                          if (e == bloc.imagesList.last) {
                            return Wrap(
                              children: <Widget>[
                                ImageContainer(
                                  e: e,
                                  index: bloc.imagesList.indexOf(e),
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
                                      onPressed: bloc.getImageFromGallery,
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
    );
  }
}

class ImageContainer extends StatelessWidget {
  final e;
  final index;

  const ImageContainer({Key? key, this.e, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
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
                    HomeScreenCubit.get(context).removeImage(index);
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
