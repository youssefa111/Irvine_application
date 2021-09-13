import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import '../../helper/componants/homescreen_componants/drawer.dart';
import '../../helper/componants/homescreen_componants/filter_dialog.dart';
import '../../helper/componants/homescreen_componants/top_container.dart';
import '../../helper/constants/constants.dart';
import '../add_screens/news_screen.dart';
import '../add_screens/report_category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: linearGradient,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Irvine',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: HomeDrawer(),
      body: HomeBody(),
      // bottomSheet: Row(
      //   children: <Widget>[
      //     Expanded(
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      //         child: TextField(
      //           decoration: InputDecoration(
      //             labelText: 'Search for Information',
      //             isDense: true,
      //           ),
      //         ),
      //       ),
      //     ),
      //     TextButton(
      //       style: TextButton.styleFrom(
      //         backgroundColor: Theme.of(context).primaryColor,
      //       ),
      //       onPressed: () {},
      //       child: FittedBox(
      //         child: Text(
      //           'Find',
      //           style: TextStyle(
      //             color: Colors.white,
      //           ),
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       width: 15,
      //     ),
      //   ],
      // ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(0), child: ViewSection());
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
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TopContainer(
              height: 100,
              width: screenWidth / 3,
              imagePath: 'assets/forbidden.jpg',
              title: 'Report an issue',
              widget: ReportCategoryScreen(),
            ),
            TopContainer(
              height: 100,
              width: screenWidth / 3,
              imagePath: 'assets/map2.jpg',
              title: 'Add news',
              widget: NewsScreen(),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Spacer(),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context, builder: (context) => FilterDialog());
              },
              icon: FaIcon(
                FontAwesomeIcons.slidersH,
              ),
            ),
          ],
        ),
        Expanded(child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () => HomeScreenCubit.get(context).getHomeData(),
              child: state is HomeScreenLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) =>
                          state is FilteredSucessfully
                              ? HomeScreenCubit.get(context).filterList[index]
                              : HomeScreenCubit.get(context).dataList[index],
                      separatorBuilder: (context, index) => Container(
                            color: Colors.grey[350],
                            width: double.infinity,
                            height: 5,
                          ),
                      itemCount: state is FilteredSucessfully
                          ? HomeScreenCubit.get(context).filterList.length
                          : HomeScreenCubit.get(context).dataList.length),
            );
          },
        )),
      ],
    );
  }
}
