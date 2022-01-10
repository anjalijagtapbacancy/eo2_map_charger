import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Connection.dart';
import 'ConstantFunction/custom_navigation.dart';
import 'ConstantFunction/Constants.dart';
import 'VisibilityWidgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VisibilityWidgets>(
            create: (context) => VisibilityWidgets()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VisibilityWidgets visibilityWidgetsRead;

  @override
  void initState() {
    super.initState();
    //ConnectServer(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
      visibilityWidgetsRead.MacAddress();
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      CustomNavigation.pushReplacement(
          context: context, className: Connection());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetConstants.splash_screen),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 5, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 200.0, height: 100.0),
                Image(
                  image: AssetImage(AssetConstants.app_logo),
                  height: 150,
                ),
                Image(
                  image: AssetImage(AssetConstants.charging_gun),
                  height: 250,
                ),
                Text(
                  'Powered by EO2 Evse Private Limited',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
