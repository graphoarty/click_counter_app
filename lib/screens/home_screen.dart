import 'dart:math';

import 'package:click_counter_app/base/app_styles.dart';
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

  void _incrementCounter() {
    setState(() {
      _counter += _incrementer;
    });

    HomeWidget.saveWidgetData('counter', _counter);
    HomeWidget.updateWidget(iOSName: iOSWidget);
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }

    HomeWidget.saveWidgetData('counter', _counter);
    HomeWidget.updateWidget(iOSName: iOSWidget);
  }

  void _clearCounter() {
    setState(() {
      _counter = 0;
    });

    HomeWidget.saveWidgetData('counter', _counter);
    HomeWidget.updateWidget(iOSName: iOSWidget);
  }

  @override
  void initState() {
    HomeWidget.setAppGroupId(appGroupId);
    print('this is working!');
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
                                        onPressed: () {
                                          setState(() {
                                            _incrementer =
                                                max(1, --_incrementer);
                                          });
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
                                        onPressed: () {
                                          setState(() {
                                            _incrementer++;
                                          });
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
