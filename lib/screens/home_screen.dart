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

  void _incrementCounter() {
    setState(() {
      _counter++;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: AppStyles.GetTitleTextStyleByWidth(screenWidth),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _incrementCounter,
                  child: Text(
                    '+',
                    style: AppStyles.GetTitleTextStyleByWidth(screenWidth)
                        .copyWith(
                            color: Colors.black, fontWeight: FontWeight.normal),
                    // style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
