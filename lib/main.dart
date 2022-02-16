import 'package:eo2_map_charger/Home.dart';
import 'package:eo2_map_charger/user_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Connection.dart';
import 'ConstantFunction/custom_navigation.dart';
import 'ConstantFunction/Constants.dart';
import 'ConstantFunction/size_constants.dart';
import 'VisibilityWidgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      visibilityWidgetsRead.UserName();
      visibilityWidgetsRead.MacAddress();
    });
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (visibilityWidgetsRead.user_name == "" ||
          visibilityWidgetsRead.user_name == " " ||
          visibilityWidgetsRead.user_name == null) {
        CustomNavigation.pushReplacement(
            context: context, className: UserName());
      } else {
        if (visibilityWidgetsRead.qrText == "" ||
            visibilityWidgetsRead.qrText == " " ||
            visibilityWidgetsRead.qrText == null) {
          CustomNavigation.pushReplacement(
              context: context, className: Connection());
        } else {
          CustomNavigation.pushReplacement(context: context, className: Home());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConstants.setScreenAwareConstant(context);
    return Scaffold(
      backgroundColor:  Constants.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height:ScreenUtil().setHeight(50)),
                  Image(
                    image: AssetImage(AssetConstants.app_logo),
                    height: ScreenUtil().setHeight(100),
                  ),
                  Image(
                    image: AssetImage(AssetConstants.charging_gun),
                    height: ScreenUtil().setHeight(350)
                  ),
                  Column(
                    children: [
                      Text(
                        'Powered by',
                        style: TextStyle(color: Constants.black,fontSize: 14.sp),
                      ),
                      Text(
                        'EO2 Evse Private Limited',
                        style: TextStyle(color: Constants.green,fontSize: 14.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
