import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';
import '../../helper/componants/homescreen_componants/drawer.dart';
import '../../helper/componants/homescreen_componants/filter_dialog.dart';
import '../../helper/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

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
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      drawer: BlocBuilder<HomeScreenCubit, HomeScreenState>(
        builder: (context, state) {
          var _userData = HomeScreenCubit.get(context).userData;
          return HomeDrawer(model: _userData);
        },
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ViewSection());
  }
}

class ViewSection extends StatefulWidget {
  const ViewSection({Key? key}) : super(key: key);

  @override
  _ViewSectionState createState() => _ViewSectionState();
}

class _ViewSectionState extends State<ViewSection> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void searchCategory(String query) {}

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black, fontSize: 12);
    final styleHint = TextStyle(color: Colors.black54, fontSize: 12);
    final style = controller.text.isEmpty ? styleHint : styleActive;
    return Column(
      children: <Widget>[
        Container(
          height: 42,
          margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
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

                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                    : null,
                hintText: 'Search',
                hintStyle: style,
                border: InputBorder.none,
              ),
              style: style,
              onChanged: (String searchPost) {
                HomeScreenCubit.get(context).search(searchPost);
              }),
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
        Expanded(
            child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
          listener: (context, state) {},
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () => HomeScreenCubit.get(context).getHomeData(),
              child: state is HomeScreenLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) => controller.text.isEmpty
                          ? HomeScreenCubit.get(context).dataList[index]
                          : HomeScreenCubit.get(context).searchList[index],
                      separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                      itemCount: controller.text.isEmpty
                          ? HomeScreenCubit.get(context).dataList.length
                          : HomeScreenCubit.get(context).searchList.length),
            );
          },
        )),
      ],
    );
  }
}
