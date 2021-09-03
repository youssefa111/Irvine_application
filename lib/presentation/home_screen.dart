import 'package:first_task/componants.dart';
import 'package:first_task/presentation/report_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Irvine'),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: Column(),
        ),
      ),
      body: HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ReportCategoryScreen())),
        child: FittedBox(child: Text('Report')),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0), child: ViewSection());
  }
}

// class TopSection extends StatelessWidget {
//   const TopSection({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//     return Container(
//       height: screenHeight * .15,
//       width: screenWidth,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           TopContainer(
//               height: screenHeight * .2,
//               width: screenWidth / 4,
//               imagePath: 'assets/forbidden.jpg',
//               title: 'Report Hate Crime'),
//           TopContainer(
//               height: screenHeight * .2,
//               width: screenWidth / 4,
//               imagePath: 'assets/map1.jpg',
//               title: 'Report an issue'),
//           TopContainer(
//               height: screenHeight * .2,
//               width: screenWidth / 4,
//               imagePath: 'assets/map2.jpg',
//               title: 'Neighborhood Activity'),
//         ],
//       ),
//     );
//   }
// }

class ViewSection extends StatelessWidget {
  const ViewSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TopContainer(
                height: 140,
                width: screenWidth / 4,
                imagePath: 'assets/forbidden.jpg',
                title: 'Report Hate Crime'),
            TopContainer(
                height: 140,
                width: screenWidth / 4,
                imagePath: 'assets/map1.jpg',
                title: 'Report an issue'),
            TopContainer(
                height: 140,
                width: screenWidth / 4,
                imagePath: 'assets/map2.jpg',
                title: 'Neighborhood Activity'),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Alerts & New',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.slidersH,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        NewsContainer(
          reporterName: 'Public information office Linda Fontos',
          newsTitle: 'Mayor Khan Discusses the New Covid-19 and he talks about',
          newsContent:
              'Mayor Farrah N.Khan discuess a few of the actions she taken in her first few weeks as irvine s mayor - the creation the the of the COVID-19 Task Force and Business',
          newsDate: '21 Dec',
          iconLetter: 'I',
          isAgency: true,
          newsThanks: 1,
          newsReplies: 0,
        ),
        SizedBox(
          height: 20,
        ),
        NewsContainer(
          reporterName: 'Jas NewMn WoodBUD SouthLake',
          newsTitle: 'Natinal Law Enforcement Appreciation Day',
          newsContent:
              'I did no make it up, i watch EVERY council meeting and she stated prior to being Mayor that she wanted to defunt the Irvine Police Department. I believe it was at a council.',
          newsDate: '17 Jan',
          iconLetter: 'I',
          isAgency: false,
          newsThanks: 147,
          newsReplies: 41,
        ),
        SizedBox(
          height: 20,
        ),
        ReportContainer(
          reporterName: 'James Wine Portota Springo',
          reportContent:
              'Hi Neighbors, Does anyone Know who i need to contact to get this grafitti removed? Location is at Bridge',
          reportImage: 'assets/grifatti.jpg',
          reportName: 'Reported Grafitti',
          reportLocation: '1.2 miles away',
          reporterLetter: 'J',
        ),
      ],
    );
  }
}
