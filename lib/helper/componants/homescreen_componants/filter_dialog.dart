import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/cubit/homescreen_cubit/home_screen_cubit.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  int? filterGroup = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            height: MediaQuery.of(context).size.height * .35,
            width: MediaQuery.of(context).size.width * .5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Radio<int>(
                        activeColor: Colors.black,
                        value: 1,
                        groupValue: cubit.filterGroup,
                        onChanged: (value) {
                          cubit.changeFilter(value!);
                        },
                      ),
                      Text('All'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<int>(
                        activeColor: Colors.black,
                        value: 2,
                        groupValue: cubit.filterGroup,
                        onChanged: (value) {
                          cubit.changeFilter(value!);
                        },
                      ),
                      Text('Reports'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio<int>(
                        activeColor: Colors.black,
                        value: 3,
                        groupValue: cubit.filterGroup,
                        onChanged: (value) {
                          cubit.changeFilter(value!);
                        },
                      ),
                      Text('News'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      BlocBuilder<HomeScreenCubit, HomeScreenState>(
                        builder: (context, state) {
                          return TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              HomeScreenCubit.get(context)
                                  .filterHome(cubit.filterGroup!.toInt());
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
