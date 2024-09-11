import 'dart:math';

import 'package:click_counter_app/base/app_styles.dart';
import 'package:click_counter_app/base/utils.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  String appGroupId = "group.click-counter-app-group";
  String iOSWidget = "ClickCounterWidget";

  int _counter = 0;
  int _incrementer = 1;

  void _incrementCounter() async {
    setState(() {
      _counter += _incrementer;
    });

    (await GetSharedPreferences()).setInt('counter', _counter);
    HomeWidget.saveWidgetData('counter', _counter);
    HomeWidget.updateWidget(iOSName: iOSWidget);
  }

  void _decrementCounter() async {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }

    (await GetSharedPreferences()).setInt('counter', _counter);
    HomeWidget.saveWidgetData('counter', _counter);
    HomeWidget.updateWidget(iOSName: iOSWidget);
  }

  void _clearCounter() async {
    setState(() {
      _counter = 0;
    });

    (await GetSharedPreferences()).setInt('counter', _counter);
    HomeWidget.saveWidgetData('counter', _counter);
    HomeWidget.updateWidget(iOSName: iOSWidget);
  }

  void HouseKeeping() async {
    HomeWidget.setAppGroupId(appGroupId);

    int tempCounter = (await GetSharedPreferences()).getInt("counter") ?? 0;
    int tempIncrementer =
        (await GetSharedPreferences()).getInt("increment") ?? 1;

    setState(() {
      _counter = tempCounter;
      _incrementer = tempIncrementer;
    });

    HomeWidget.saveWidgetData('counter', _counter);
    HomeWidget.saveWidgetData('incrementer', _incrementer);
  }

  @override
  void initState() {
    HouseKeeping();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      int tempCounter = await HomeWidget.getWidgetData('counter');
      setState(() {
        _counter = tempCounter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyles.buttonBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: _decrementCounter,
                      child: Text(
                        '-',
                        style: AppStyles.GetSignageTextStyleByWidth(screenWidth)
                            .copyWith(
                                color: AppStyles.buttonTextColor,
                                fontWeight: FontWeight.normal),
                        // style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyles.buttonBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: _incrementCounter,
                      child: Text(
                        '+',
                        style: AppStyles.GetSignageTextStyleByWidth(screenWidth)
                            .copyWith(
                                color: AppStyles.buttonTextColor,
                                fontWeight: FontWeight.normal),
                        // style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              '$_counter',
              style: AppStyles.GetCounterTextStyleByWidth(screenWidth)
                  .copyWith(color: AppStyles.buttonTextColor),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                      return 0;
                    },
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.transparent;
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.white;
                    },
                  ),
                ),
                onPressed: _clearCounter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Icon(Icons.close,
                      size: (screenWidth / 12.5), color: Colors.white),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                      return 0;
                    },
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.transparent;
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.transparent;
                    },
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Wrap(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Incrementer',
                                    style: AppStyles.GetTitleTextStyleByWidth(
                                            screenWidth)
                                        .copyWith(color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          elevation: MaterialStateProperty
                                              .resolveWith<double>(
                                            (Set<MaterialState> states) {
                                              return 0;
                                            },
                                          ),
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              return Colors.transparent;
                                            },
                                          ),
                                          foregroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              return Colors.white;
                                            },
                                          ),
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            _incrementer =
                                                max(1, --_incrementer);
                                          });

                                          (await GetSharedPreferences()).setInt(
                                              'incrementer', _incrementer);
                                          HomeWidget.saveWidgetData(
                                              'incrementer', _incrementer);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 25),
                                          child: Icon(Icons.remove,
                                              size: (screenWidth / 12.5),
                                              color: Colors.black),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        '$_incrementer',
                                        style: AppStyles
                                                .GetIncrementerTextStyleByWidth(
                                                    screenWidth)
                                            .copyWith(color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          elevation: MaterialStateProperty
                                              .resolveWith<double>(
                                            (Set<MaterialState> states) {
                                              return 0;
                                            },
                                          ),
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              return Colors.transparent;
                                            },
                                          ),
                                          foregroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              return Colors.white;
                                            },
                                          ),
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            _incrementer++;
                                          });

                                          (await GetSharedPreferences()).setInt(
                                              'incrementer', _incrementer);
                                          HomeWidget.saveWidgetData(
                                              'incrementer', _incrementer);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 25),
                                          child: Icon(Icons.add,
                                              size: (screenWidth / 12.5),
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 75,
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Icon(Icons.menu,
                      size: (screenWidth / 12.5), color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
