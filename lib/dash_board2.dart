import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprintf/sprintf.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'CommonWidgets.dart';
import 'Connection.dart';
import 'ConstantFunction/Constants.dart';
import 'ConstantFunction/size_constants.dart';
import 'VisibilityWidgets.dart';
import 'ev_analysis.dart';

class DashBoard2 extends StatefulWidget {
  @override
  dashboard_state createState() => dashboard_state();

  DashBoard2();
}

enum ConfirmAction { Cancel, Accept }

class dashboard_state extends State<DashBoard2>
    with SingleTickerProviderStateMixin {
  var animationValue = 0.0;
  var linearAnimation;
  var linearAnimationController;

  String ChargingText, NextChargingText;
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;

  //StreamSubscription subscription;

  dashboard_state();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
      visibilityWidgetsRead.setappbar_name("Dashboard");
      visibilityWidgetsRead.setCurrentLog(true);
      visibilityWidgetsRead.setisResponse8(false);
      Future.delayed(
        Duration(seconds: visibilityWidgetsRead.TIMEDELAY),
      ).then((value) => {
            if (mounted)
              {
                if (visibilityWidgetsRead.isResponse8 == false)
                  {
                    visibilityWidgetsRead.responseMsgId8 = null,
                    if (visibilityWidgetsRead.socket != null)
                      visibilityWidgetsRead.socket.close(),
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Connection()),
                        (Route<dynamic> route) => false)
                  }
              }
          });
    });
    linearAnimationController = AnimationController(
        duration: const Duration(milliseconds: 2500), vsync: this);

    linearAnimation =
        CurvedAnimation(parent: linearAnimationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {
              animationValue = (linearAnimation.value) * 360;
            });
          });
    linearAnimationController.repeat();
  }

  @override
  void dispose() {
    // visibilityWidgetsRead.responseMsgId8 = null;
    linearAnimationController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    SizeConstants.setScreenAwareConstant(context);
    if (mounted && visibilityWidgetsWatch.responseMsgId8 != null)
      visibilityWidgetsWatch.Network(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
                child: visibilityWidgetsWatch.responseMsgId8 != null &&
                        visibilityWidgetsWatch.readyLoader == false &&
                        visibilityWidgetsWatch.stopLoader == false
                    ? Center(
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.person,color: Constants.blue,size:0.1.sw,),
                                  Text(
                                    "Hi  ${visibilityWidgetsWatch.user_name}!",
                                    style: TextStyle(fontSize:25.sp,color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(5),
                                    height: ScreenUtil().setHeight(5),
                                  ),
                                  RaisedButton(
                                    textColor: Colors.black,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Image(
                                            image: const AssetImage(
                                                AssetConstants.ic_ev_analysis),
                                            color: Colors.grey,
                                            width: ScreenUtil().setWidth(30),
                                            height: ScreenUtil().setHeight(25),
                                          ),
                                          Text("Ev Analysis"),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      visibilityWidgetsWatch.ClearLists();
                                      visibilityWidgetsWatch.SendRequest12(12, 1);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EvAnalysis()));
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                  child: Padding(
                                      padding:
                                           EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: ScreenUtil().setHeight(20),
                                          ),
                                          Visibility(
                                            child: Padding(
                                              padding:  EdgeInsets.fromLTRB(10, 0, 10, 5),
                                              child: Text(
                                                "${visibilityWidgetsWatch.Tips()}",
                                                style: TextStyle(
                                                    fontSize: 17.sp,
                                                    wordSpacing: 1.0,
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            visible: visibilityWidgetsWatch.isTip(),
                                          ),
                                          Padding(
                                            padding:
                                                 EdgeInsets.fromLTRB(0, 0, 0, 5),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Visibility(
                                                  child: SizedBox(
                                                    width: ScreenUtil().setWidth(70),
                                                    height: ScreenUtil().setHeight(70),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        final pref =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        visibilityWidgetsWatch
                                                            .setStartHour((pref.getInt(
                                                                        'startHour') !=
                                                                    null)
                                                                ? pref
                                                                    .getInt('startHour')
                                                                : 00);
                                                        visibilityWidgetsWatch
                                                            .setStartMinute((pref.getInt(
                                                                        'startMinute') !=
                                                                    null)
                                                                ? pref.getInt(
                                                                    'startMinute')
                                                                : 00);
                                                        visibilityWidgetsWatch
                                                            .setEndHour((pref.getInt(
                                                                        'endHour') !=
                                                                    null)
                                                                ? pref.getInt('endHour')
                                                                : 00);
                                                        visibilityWidgetsWatch
                                                            .setEndMinute((pref.getInt(
                                                                        'endMinute') !=
                                                                    null)
                                                                ? pref
                                                                    .getInt('endMinute')
                                                                : 00);
                                                        visibilityWidgetsWatch
                                                            .setisScheduling((pref.getBool(
                                                                        'isScheduling') !=
                                                                    null)
                                                                ? pref.getBool(
                                                                    'isScheduling')
                                                                : false);

                                                        showModalBottomSheet<void>(
                                                          context: context,
                                                          builder:
                                                              (BuildContext context) {
                                                            return StatefulBuilder(
                                                                builder: (BuildContext
                                                                        context,
                                                                    StateSetter
                                                                        setState) {
                                                              return SingleChildScrollView(
                                                                child: Container(
                                                                  color: Colors.white,
                                                                  child: Padding(
                                                                    padding:
                                                                         EdgeInsets
                                                                            .all(8),
                                                                    child: Center(
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceEvenly,
                                                                        mainAxisSize:
                                                                            MainAxisSize
                                                                                .max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        children: <
                                                                            Widget>[
                                                                           Text(
                                                                            'Schedule Charging',
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    20.sp,
                                                                                fontWeight:
                                                                                    FontWeight.bold),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(
                                                                                    5.0),
                                                                            child: Row(
                                                                              mainAxisSize:
                                                                                  MainAxisSize
                                                                                      .max,
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment
                                                                                      .spaceBetween,
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment
                                                                                      .center,
                                                                              children: [
                                                                                Text(
                                                                                  "Scheduling",
                                                                                  style: TextStyle(
                                                                                      fontSize: 19.sp,
                                                                                      color: Colors.grey[600],
                                                                                      fontWeight: FontWeight.bold),
                                                                                ),
                                                                                Switch(
                                                                                  onChanged:
                                                                                      (bool value) {
                                                                                    setState(() {
                                                                                      if (value == false) {
                                                                                        visibilityWidgetsWatch.setisScheduling(false);
                                                                                      } else {
                                                                                        visibilityWidgetsWatch.setisScheduling(true);
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  value:
                                                                                      visibilityWidgetsWatch.isScheduling,
                                                                                  activeColor:
                                                                                  Constants.blue,
                                                                                  activeTrackColor:
                                                                                      Colors.grey,
                                                                                  inactiveThumbColor:
                                                                                      Colors.black,
                                                                                  inactiveTrackColor:
                                                                                      Colors.grey,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(
                                                                                    8.0),
                                                                            child: Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child:
                                                                                      GestureDetector(
                                                                                    child:
                                                                                        Card(
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                                      ),
                                                                                      color: Colors.white,
                                                                                      elevation: 10,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(20.0),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              "${visibilityWidgetsWatch.startHour}:${visibilityWidgetsWatch.startMinute}",
                                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: ScreenUtil().setHeight(15),
                                                                                              width: ScreenUtil().setWidth(20),
                                                                                            ),
                                                                                            Text(
                                                                                              "Start of Charging",
                                                                                              style: TextStyle(color: Colors.grey[600]),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    onTap:
                                                                                        () async {
                                                                                      var selectedTime = TimeOfDay(hour: visibilityWidgetsWatch.startHour, minute: visibilityWidgetsWatch.startMinute);
                                                                                      final TimeOfDay timeOfDay = await showTimePicker(
                                                                                        context: context,
                                                                                        initialTime: selectedTime,
                                                                                        initialEntryMode: TimePickerEntryMode.dial,
                                                                                      );
                                                                                      if (timeOfDay != null) {
                                                                                        setState(() {
                                                                                          selectedTime = timeOfDay;
                                                                                          visibilityWidgetsWatch.setStartHour(timeOfDay.hour);
                                                                                          visibilityWidgetsWatch.setStartMinute(timeOfDay.minute);
                                                                                        });
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child:
                                                                                      GestureDetector(
                                                                                    child:
                                                                                        Card(
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(15.0),
                                                                                      ),
                                                                                      color: Colors.white,
                                                                                      elevation: 10,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(20.0),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              "${visibilityWidgetsWatch.endHour}:${visibilityWidgetsWatch.endMinute}",
                                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: ScreenUtil().setHeight(15),
                                                                                              width: ScreenUtil().setWidth(20),
                                                                                            ),
                                                                                            Text(
                                                                                              "End of Charging",
                                                                                              style: TextStyle(color: Colors.grey[600]),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    onTap:
                                                                                        () async {
                                                                                      var selectedTime = TimeOfDay(hour: visibilityWidgetsWatch.endHour, minute: visibilityWidgetsWatch.endMinute);
                                                                                      final TimeOfDay timeOfDay = await showTimePicker(
                                                                                        context: context,
                                                                                        initialTime: selectedTime,
                                                                                        initialEntryMode: TimePickerEntryMode.dial,
                                                                                      );
                                                                                      if (timeOfDay != null) {
                                                                                        setState(() {
                                                                                          selectedTime = timeOfDay;
                                                                                          visibilityWidgetsWatch.setEndHour(timeOfDay.hour);
                                                                                          visibilityWidgetsWatch.setEndMinute(timeOfDay.minute);
                                                                                        });
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: ScreenUtil().setHeight(120),
                                                                            child: SfRadialGauge(
                                                                                axes: <
                                                                                    RadialAxis>[
                                                                                  RadialAxis(
                                                                                    axisLineStyle:
                                                                                        AxisLineStyle(
                                                                                      color: Colors.grey,
                                                                                      thickness: 0.2,
                                                                                      thicknessUnit: GaugeSizeUnit.factor,
                                                                                    ),
                                                                                    startAngle:
                                                                                        270,
                                                                                    maximum:
                                                                                        1440,
                                                                                    endAngle:
                                                                                        270,
                                                                                    minimum:
                                                                                        0,
                                                                                    showLabels:
                                                                                        false,
                                                                                    showTicks:
                                                                                        false,
                                                                                    pointers: <GaugePointer>[
                                                                                      RangePointer(
                                                                                        value: visibilityWidgetsWatch.timeDiffernce(),
                                                                                        width: 0.2,
                                                                                        enableAnimation: true,
                                                                                        sizeUnit: GaugeSizeUnit.factor,
                                                                                        gradient: const SweepGradient(colors: <Color>[
                                                                                          Color.fromARGB(
                                                                                              255,
                                                                                              170,
                                                                                              237,
                                                                                              248),
                                                                                          Color.fromARGB(
                                                                                              255,
                                                                                              92,
                                                                                              217,
                                                                                              239),
                                                                                          Color.fromARGB(
                                                                                              255,
                                                                                              58,
                                                                                              187,
                                                                                              238),
                                                                                          Color.fromARGB(
                                                                                              255,
                                                                                              7,
                                                                                              172,
                                                                                              239),
                                                                                        ], stops: <double>[
                                                                                          0.20,
                                                                                          0.40,
                                                                                          0.60,
                                                                                          0.80
                                                                                        ]),
                                                                                      )
                                                                                    ],
                                                                                    annotations: [
                                                                                      GaugeAnnotation(
                                                                                        widget: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                                          children: [
                                                                                            // SizedBox(
                                                                                            //   width: ScreenUtil().setWidth(11),
                                                                                            //   height: ScreenUtil().setHeight(5),
                                                                                            // ),
                                                                                            Text(
                                                                                              sprintf('%2d:%02d', [
                                                                                                visibilityWidgetsWatch.hour_diff,
                                                                                                visibilityWidgetsWatch.min_diff
                                                                                              ]),
                                                                                              style: TextStyle(color: Constants.blue, fontSize: 19),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        positionFactor: 0.1,
                                                                                        angle: 90,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ]),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .spaceEvenly,
                                                                            mainAxisSize:
                                                                                MainAxisSize
                                                                                    .max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment
                                                                                    .center,
                                                                            children: [
                                                                              RaisedButton(
                                                                                textColor:
                                                                                    Colors.black,
                                                                                color: Colors
                                                                                    .white,
                                                                                child:
                                                                                    Padding(
                                                                                  padding:
                                                                                      const EdgeInsets.all(8.0),
                                                                                  child:
                                                                                      SizedBox(
                                                                                    width:
                                                                                        100,
                                                                                    child:
                                                                                        Center(
                                                                                      child: Text("Cancel", style: TextStyle(fontSize: 15)),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                onPressed:
                                                                                    () {
                                                                                  Navigator.pop(
                                                                                      context);
                                                                                },
                                                                                shape:
                                                                                    RoundedRectangleBorder(
                                                                                  borderRadius:
                                                                                      BorderRadius.circular(30.0),
                                                                                ),
                                                                              ),
                                                                              RaisedButton(
                                                                                textColor:
                                                                                    Colors.black,
                                                                                color: Colors
                                                                                    .white,
                                                                                child:
                                                                                    Padding(
                                                                                  padding:
                                                                                      const EdgeInsets.all(8.0),
                                                                                  child:
                                                                                      SizedBox(
                                                                                    width: ScreenUtil().setWidth(100),
                                                                                    child:
                                                                                        Center(
                                                                                      child: Text("Set", style: TextStyle(fontSize: 15)),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                onPressed:
                                                                                    () async {
                                                                                  int wdStartTime =
                                                                                      (visibilityWidgetsWatch.startHour * 100) + visibilityWidgetsWatch.startMinute;
                                                                                  int wdEndTime =
                                                                                      (visibilityWidgetsWatch.endHour * 100) + visibilityWidgetsWatch.endMinute;
                                                                                  int maxCurrent = [
                                                                                    6,
                                                                                    10,
                                                                                    15,
                                                                                    18,
                                                                                    24,
                                                                                    30
                                                                                  ][visibilityWidgetsWatch
                                                                                      .currentMax
                                                                                      .round()];
                                                                                  visibilityWidgetsWatch.SendRequest2(
                                                                                      2,
                                                                                      visibilityWidgetsWatch.isScheduling,
                                                                                      wdStartTime,
                                                                                      wdEndTime,
                                                                                      1,
                                                                                      1,
                                                                                      maxCurrent);
                                                                                  Navigator.pop(
                                                                                      context);
                                                                                },
                                                                                shape:
                                                                                    RoundedRectangleBorder(
                                                                                  borderRadius:
                                                                                      BorderRadius.circular(30.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                          },
                                                        );
                                                      },
                                                      child: Image(
                                                        image: AssetImage(AssetConstants
                                                            .ic_schedule_charging),
                                                      ),
                                                    ),
                                                  ),
                                                  visible: visibilityWidgetsWatch
                                                      .isbtnScheduling(),
                                                ),
                                                Visibility(
                                                  child: Expanded(
                                                    child: SizedBox(
                                                      width: ScreenUtil().setWidth(170),
                                                      height: ScreenUtil().setHeight(170),
                                                    ),
                                                  ),
                                                  visible: visibilityWidgetsWatch
                                                      .isSizedBox(),
                                                ),
                                                Visibility(
                                                  child: Expanded(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        visibilityWidgetsWatch
                                                            .clearData();
                                                        visibilityWidgetsWatch
                                                            .setReadyLoader(true);
                                                        visibilityWidgetsWatch
                                                            .SendRequest3(3, 1);
                                                        await Future.delayed(
                                                            Duration(seconds: 1));
                                                        visibilityWidgetsWatch
                                                            .CommonRequests(8);
                                                      },
                                                      child: Container(
                                                        width: ScreenUtil().setWidth(170),
                                                        height: ScreenUtil().setHeight(170),
                                                        decoration: new BoxDecoration(
                                                          color: Colors.white,
                                                          shape: BoxShape.circle,
                                                          border: new Border.all(
                                                            color: Constants.blue,
                                                            width: ScreenUtil().setWidth(15),
                                                          ),
                                                        ),
                                                        child: new Center(
                                                          child: new Text(
                                                            'Ready',
                                                            style: TextStyle(
                                                                fontSize: 17.sp,
                                                                color: Constants.blue,
                                                                fontWeight:
                                                                    FontWeight.bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  visible: visibilityWidgetsWatch
                                                      .isbtnReady(),
                                                ),
                                                Visibility(
                                                  child: SizedBox(
                                                    width: ScreenUtil().setWidth(70),
                                                    height: ScreenUtil().setHeight(70),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        final pref =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        visibilityWidgetsWatch
                                                            .setCurrentMax((pref.getInt(
                                                                        'currentMax') !=
                                                                    null)
                                                                ? pref.getInt(
                                                                    'currentMax')
                                                                : 5);
                                                        showModalBottomSheet<void>(
                                                          context: context,
                                                          builder:
                                                              (BuildContext context) {
                                                            return StatefulBuilder(
                                                                builder: (BuildContext
                                                                        context,
                                                                    StateSetter
                                                                        setState) {
                                                              return SingleChildScrollView(
                                                                child: SizedBox(
                                                                  height: ScreenUtil().setHeight(300),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Text(
                                                                        "Boost Mode",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight
                                                                                    .bold,
                                                                            fontSize:
                                                                                20),
                                                                      ),
                                                                      Text(
                                                                        [
                                                                              6,
                                                                              10,
                                                                              15,
                                                                              18,
                                                                              24,
                                                                              30
                                                                            ][visibilityWidgetsWatch
                                                                                    .currentMax
                                                                                    .round()]
                                                                                .toString() +
                                                                            " A",
                                                                        style: TextStyle(
                                                                            color: Constants.blue,
                                                                            fontSize:
                                                                                20.sp),
                                                                      ),
                                                                      Slider(
                                                                        value: visibilityWidgetsWatch
                                                                            .currentMax
                                                                            .toDouble(),
                                                                        min: 0,
                                                                        max: 5,
                                                                        divisions: 5,
                                                                        inactiveColor: Colors.grey[300],
                                                                        label: [
                                                                          6,
                                                                          10,
                                                                          15,
                                                                          18,
                                                                          24,
                                                                          30
                                                                        ][visibilityWidgetsWatch
                                                                                .currentMax
                                                                                .round()]
                                                                            .toString(),
                                                                        activeColor:
                                                                        Constants.blue,
                                                                        onChanged:
                                                                            (double
                                                                                value) {
                                                                          setState(() {
                                                                            visibilityWidgetsWatch
                                                                                .setCurrentMax(
                                                                                    value.round());
                                                                          });
                                                                        },
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets
                                                                                    .all(
                                                                                10.0),
                                                                        child: Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize
                                                                                  .max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment
                                                                                  .spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                          children: [
                                                                            Text("Slow",
                                                                                style: TextStyle(
                                                                                    color:
                                                                                        Colors.grey[600],
                                                                                    fontSize: 15.sp)),
                                                                            Text(
                                                                                "Moderate",
                                                                                style: TextStyle(
                                                                                    color:
                                                                                        Colors.grey[600],
                                                                                    fontSize: 15.sp)),
                                                                            Text("Fast",
                                                                                style: TextStyle(
                                                                                    color:
                                                                                        Colors.grey[600],
                                                                                    fontSize: 15.sp)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceEvenly,
                                                                        mainAxisSize:
                                                                            MainAxisSize
                                                                                .max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          RaisedButton(
                                                                            textColor:
                                                                                Colors
                                                                                    .black,
                                                                            color: Colors
                                                                                .white,
                                                                            child:
                                                                                Padding(
                                                                              padding:
                                                                                  const EdgeInsets.all(
                                                                                      8.0),
                                                                              child:
                                                                                  SizedBox(
                                                                                width:
                                                                                ScreenUtil().setWidth(100),
                                                                                child:
                                                                                    Center(
                                                                                  child: Text(
                                                                                      "Cancel",
                                                                                      style: TextStyle(fontSize: 15.sp)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(
                                                                                  context);
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius:
                                                                                  BorderRadius.circular(
                                                                                      30.0),
                                                                            ),
                                                                          ),
                                                                          RaisedButton(
                                                                            textColor:
                                                                                Colors
                                                                                    .black,
                                                                            color: Colors
                                                                                .white,
                                                                            child:
                                                                                Padding(
                                                                              padding:
                                                                                  const EdgeInsets.all(
                                                                                      8.0),
                                                                              child:
                                                                                  SizedBox(
                                                                                width:
                                                                                ScreenUtil().setWidth(100),
                                                                                child:
                                                                                    Center(
                                                                                  child: Text(
                                                                                      "Set",
                                                                                      style: TextStyle(fontSize: 15.sp)),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              visibilityWidgetsWatch.SendRequest13(
                                                                                  13,
                                                                                  [
                                                                                    6,
                                                                                    10,
                                                                                    15,
                                                                                    18,
                                                                                    24,
                                                                                    30
                                                                                  ][visibilityWidgetsWatch
                                                                                      .currentMax
                                                                                      .round()]);
                                                                              Navigator.pop(
                                                                                  context);
                                                                            },
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius:
                                                                                  BorderRadius.circular(
                                                                                      30.0),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                          },
                                                        );
                                                      },
                                                      child: Image(
                                                        image: AssetImage(AssetConstants
                                                            .ic_boost_mode),
                                                      ),
                                                    ),
                                                  ),
                                                  visible: visibilityWidgetsWatch
                                                      .isbtnBoost(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(10),
                                          ),
                                          Visibility(
                                            child: Padding(
                                              padding:  EdgeInsets.fromLTRB(10, 20, 10, 10),
                                              child: Text(
                                                sprintf(
                                                    'You charged last at %s by %s Charging time was %02d:%02d:%02d with energy used %.2f KWh.',
                                                    [
                                                      visibilityWidgetsWatch.timeLog,
                                                      visibilityWidgetsWatch.modLog,
                                                      visibilityWidgetsWatch.hourLog,
                                                      visibilityWidgetsWatch.minuteLog,
                                                      visibilityWidgetsWatch.secLog,
                                                      visibilityWidgetsWatch.energyLog /
                                                          1000
                                                    ]),
                                                style: TextStyle(
                                                  fontSize: 17.sp,
                                                  wordSpacing: 1.0,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            visible:
                                                visibilityWidgetsWatch.isChargingTxt(),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(10),
                                          ),
                                          Visibility(
                                            child: Padding(
                                              padding:  EdgeInsets.all(8),
                                              child: Text(
                                                sprintf(
                                                    'Your Next Charging will be at %02d:%02d.',
                                                    [
                                                      visibilityWidgetsWatch.startHour,
                                                      visibilityWidgetsWatch.startMinute
                                                    ]),
                                                style: TextStyle(
                                                    fontSize: 17.sp, wordSpacing: 0.5),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            visible: visibilityWidgetsWatch
                                                .isNextChargingTxt(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  visible: visibilityWidgetsWatch.isReadyCard(),
                                ),
                              Visibility(
                                child: SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "EV Connected",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  0, 0, 15, 0),
                                              // child: Row(
                                              //   children: [
                                              //     Expanded(
                                              //         child: SizedBox(height: ScreenUtil().setHeight(15),)),
                                              //     RaisedButton(
                                              //       textColor: Colors.black,
                                              //       color: Colors.white,
                                              //       child: Padding(
                                              //         padding:
                                              //             const EdgeInsets.all(8.0),
                                              //         child: Row(
                                              //           mainAxisSize:
                                              //               MainAxisSize.min,
                                              //           children: [
                                              //             SizedBox(
                                              //                 width: ScreenUtil().setWidth(15),
                                              //                 height: ScreenUtil().setHeight(15),
                                              //                 child: Container(
                                              //                   color: Colors.red,
                                              //                 )),
                                              //             Padding(
                                              //               padding: const EdgeInsets
                                              //                   .fromLTRB(5, 0, 0, 0),
                                              //               child: Text(
                                              //                 "Stop",
                                              //                 style: TextStyle(
                                              //                     color:
                                              //                         Colors.black),
                                              //               ),
                                              //             ),
                                              //           ],
                                              //         ),
                                              //       ),
                                              //       onPressed: () {
                                              //         visibilityWidgetsWatch
                                              //             .setStopLoader(true);
                                              //         visibilityWidgetsWatch
                                              //             .setIsPaused(true);
                                              //         visibilityWidgetsWatch
                                              //             .setChargingState(70);
                                              //         visibilityWidgetsWatch
                                              //             .SendRequest3(3, 2);
                                              //       },
                                              //       shape: RoundedRectangleBorder(
                                              //         borderRadius:
                                              //             BorderRadius.circular(30.0),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                            SizedBox(
                                              height: ScreenUtil().setHeight(300),
                                              child: SfRadialGauge(
                                                axes: <RadialAxis>[
                                                  RadialAxis(
                                                    minimum: 0,
                                                    interval: 1,
                                                    maximum: 360,
                                                    showLabels: false,
                                                    showTicks: false,
                                                    startAngle: 270,
                                                    endAngle: 270,
                                                    radiusFactor: 0.6,
                                                    useRangeColorForAxis: true,
                                                    annotations: <GaugeAnnotation>[
                                                      GaugeAnnotation(
                                                          widget: Container(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            /* AspectRatio(
                                                                aspectRatio: 7,
                                                                child: Image(
                                                                  image: AssetImage(
                                                                    AssetConstants
                                                                        .flash_charging,
                                                                  ),
                                                                ),
                                                              ),*/
                                                            Text(
                                                              sprintf(
                                                                  '%02d:%02d:%02d', [
                                                                visibilityWidgetsWatch
                                                                    .diffHour,
                                                                visibilityWidgetsWatch
                                                                    .diffMinute,
                                                                visibilityWidgetsWatch
                                                                    .diffSeconds
                                                              ]),
                                                              style: TextStyle(
                                                                  color: Constants.blue,
                                                                  wordSpacing: 3,
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                  fontSize: 15),
                                                            ),
                                                            Text(
                                                              "Charging",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight.bold,
                                                                  wordSpacing: 3,
                                                                  color: Constants.blue,
                                                                  fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                    ],
                                                    ranges: <GaugeRange>[
                                                      GaugeRange(
                                                          startValue: 0,
                                                          endValue: 360,
                                                          color: Colors.yellow[200])
                                                    ],
                                                    axisLineStyle: AxisLineStyle(
                                                      thickness: 0.05,
                                                      color: Colors.grey,
                                                      thicknessUnit:
                                                          GaugeSizeUnit.factor,
                                                    ),
                                                    pointers: <GaugePointer>[
                                                      RangePointer(
                                                          value: animationValue,
                                                          width: 0.05,
                                                          sizeUnit:
                                                              GaugeSizeUnit.factor,
                                                          color: Constants.blue)
                                                    ],
                                                  ),
                                                  // Create secondary radial axis for segmented line
                                                  RadialAxis(
                                                    minimum: 0,
                                                    interval: 1,
                                                    maximum: 20,
                                                    showLabels: true,
                                                    showTicks: true,
                                                    showAxisLine: false,
                                                    tickOffset: -0.05,
                                                    offsetUnit: GaugeSizeUnit.factor,
                                                    minorTicksPerInterval: 0,
                                                    startAngle: 270,
                                                    endAngle: 270,
                                                    radiusFactor: 0.6,
                                                    majorTickStyle: MajorTickStyle(
                                                        length: 0.1,
                                                        thickness: 5,
                                                        lengthUnit:
                                                            GaugeSizeUnit.factor,
                                                        color: Colors.white),
                                                    /* annotations: <GaugeAnnotation>[
                                                        GaugeAnnotation(
                                                            widget: Text(
                                                          'Charging',
                                                          style: TextStyle(
                                                              color: Colors.green, fontSize: 25),
                                                        ))
                                                      ]*/
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(15.0),
                                            ),
                                            color: Colors.white,
                                            elevation: 10,
                                            child: Padding(
                                              padding: const EdgeInsets.all(15.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${visibilityWidgetsWatch.chargingData.length > 0 ? (visibilityWidgetsWatch.chargingData[0].sessionEnergy / 1000).toStringAsFixed(2) : ""} KWh",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: ScreenUtil().setHeight(10),
                                                    width: ScreenUtil().setWidth(20),
                                                  ),
                                                  const Text(
                                                    "Charging Energy",
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: visibilityWidgetsWatch.chargingData.length,
                                        itemBuilder:
                                            (context, index) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                                child: Text('Phase ${index+1}',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Constants.blue),),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Card(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(15.0),
                                                        ),
                                                        color: Colors.white,
                                                        elevation: 10,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "${(visibilityWidgetsWatch.chargingData[index].current / 1000).toStringAsFixed(2)} A",
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold),
                                                              ),
                                                              SizedBox(
                                                                height: ScreenUtil().setHeight(10),
                                                                width: ScreenUtil().setWidth(20),
                                                              ),
                                                              const Text(
                                                                "Charging Current",
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Card(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(15.0),
                                                        ),
                                                        color: Colors.white,
                                                        elevation: 10,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "${(visibilityWidgetsWatch.chargingData[index].voltage / 100).toStringAsFixed(2)} V",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold),
                                                              ),
                                                              SizedBox(
                                                                height: ScreenUtil().setHeight(10),
                                                                width: ScreenUtil().setWidth(20),
                                                              ),
                                                              Text(
                                                                "Charging Voltage",
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Card(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(15.0),
                                                        ),
                                                        color: Colors.white,
                                                        elevation: 10,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "${(visibilityWidgetsWatch.chargingData[index].power / 1000).toStringAsFixed(2)} KW",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.bold),
                                                              ),
                                                              SizedBox(
                                                                height: ScreenUtil().setHeight(10),
                                                                width: ScreenUtil().setWidth(20),
                                                              ),
                                                              Text(
                                                                "Charging Power",
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      RaisedButton(
                                        textColor: Colors.black,
                                        color: Colors.white,
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                  width: ScreenUtil().setWidth(15),
                                                  height: ScreenUtil().setHeight(15),
                                                  child: Container(
                                                    color: Colors.red,
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(5, 0, 0, 0),
                                                child: Text(
                                                  "Stop",
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onPressed: () {
                                          visibilityWidgetsWatch
                                              .setStopLoader(true);
                                          visibilityWidgetsWatch
                                              .setIsPaused(true);
                                          visibilityWidgetsWatch
                                              .setChargingState(70);
                                          visibilityWidgetsWatch
                                              .SendRequest3(3, 2);
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                visible: visibilityWidgetsWatch.isChargingCard(),
                              ),
                              Visibility(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "EV Connected",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        // Row(
                                        //   children: [
                                        //     Expanded(child: SizedBox(height: ScreenUtil().setHeight(15))),
                                        //     Padding(
                                        //       padding: const EdgeInsets.fromLTRB(
                                        //           0, 0, 5, 0),
                                        //       child: RaisedButton(
                                        //         textColor: Colors.black,
                                        //         color: Colors.white,
                                        //         child: Padding(
                                        //           padding:
                                        //               const EdgeInsets.fromLTRB(
                                        //                   8, 0, 8, 0),
                                        //           child: Row(
                                        //             mainAxisSize: MainAxisSize.min,
                                        //             children: const [
                                        //               Image(
                                        //                   image: AssetImage(
                                        //                       AssetConstants
                                        //                           .resume_icon)),
                                        //               Padding(
                                        //                 padding:
                                        //                     EdgeInsets.fromLTRB(
                                        //                         5, 0, 0, 0),
                                        //                 child: Text("Resume"),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //         onPressed: () {
                                        //           visibilityWidgetsWatch
                                        //               .setIsPaused(false);
                                        //           visibilityWidgetsWatch
                                        //               .CommonRequests(8);
                                        //         },
                                        //         shape: RoundedRectangleBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(30.0),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        SizedBox(
                                          height: ScreenUtil().setHeight(200),
                                          child: SfRadialGauge(
                                            axes: <RadialAxis>[
                                              RadialAxis(
                                                minimum: 0,
                                                interval: 1,
                                                maximum: 360,
                                                showLabels: false,
                                                showTicks: false,
                                                startAngle: 270,
                                                endAngle: 270,
                                                radiusFactor: 0.6,
                                                useRangeColorForAxis: true,
                                                annotations: <GaugeAnnotation>[
                                                  GaugeAnnotation(
                                                      widget: Container(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      children: [
                                                        AspectRatio(
                                                          aspectRatio: 10.sp,
                                                          child: Image(
                                                            image: AssetImage(
                                                              AssetConstants
                                                                  .flash_charging,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Paused\nCharging",
                                                          style: TextStyle(
                                                              color: Constants.blue,
                                                              fontSize: 17.sp),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                    positionFactor: 0.0,
                                                    angle: 90,),
                                                ],
                                                ranges: <GaugeRange>[
                                                  GaugeRange(
                                                      startValue: 0,
                                                      endValue: 360,
                                                      color: Colors.yellow[200])
                                                ],
                                                axisLineStyle: AxisLineStyle(
                                                  thickness: 0.05,
                                                  color: Colors.grey,
                                                  thicknessUnit:
                                                      GaugeSizeUnit.factor,
                                                ),
                                                pointers: <GaugePointer>[
                                                  RangePointer(
                                                      value: 360,
                                                      width: 0.05,
                                                      sizeUnit:
                                                          GaugeSizeUnit.factor,
                                                      color: Constants.blue)
                                                ],
                                              ),
                                              // Create secondary radial axis for segmented line
                                              RadialAxis(
                                                minimum: 0,
                                                interval: 1,
                                                maximum: 20,
                                                showLabels: true,
                                                showTicks: true,
                                                showAxisLine: false,
                                                tickOffset: -0.05,
                                                offsetUnit: GaugeSizeUnit.factor,
                                                minorTicksPerInterval: 0,
                                                startAngle: 270,
                                                endAngle: 270,
                                                radiusFactor: 0.6,
                                                majorTickStyle: MajorTickStyle(
                                                    length: 0.1,
                                                    thickness: 5,
                                                    lengthUnit:
                                                        GaugeSizeUnit.factor,
                                                    color: Colors.white),
                                                /* annotations: <GaugeAnnotation>[
                                                      GaugeAnnotation(
                                                          widget: Text(
                                                        'Charging',
                                                        style: TextStyle(
                                                            color: Colors.green, fontSize: 25),
                                                      ))
                                                    ]*/
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              elevation: 10,
                                              child: Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${visibilityWidgetsWatch.timeLog}",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:ScreenUtil().setHeight(12),
                                                      width: ScreenUtil().setWidth(5),
                                                    ),
                                                    Text(
                                                      "Time",
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              elevation: 10,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    15, 15, 15, 15),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${visibilityWidgetsWatch.modLog}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: ScreenUtil().setHeight(15),
                                                      width: ScreenUtil().setWidth(20),
                                                    ),
                                                    Text(
                                                      "Mode Of Charging",
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              elevation: 10,
                                              child: Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      sprintf('%02d:%02d:%02d', [
                                                        visibilityWidgetsWatch
                                                            .hourLog,
                                                        visibilityWidgetsWatch
                                                            .minuteLog,
                                                        visibilityWidgetsWatch
                                                            .secLog
                                                      ]),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: ScreenUtil().setHeight(10),
                                                      width: ScreenUtil().setWidth(20),
                                                    ),
                                                    Text(
                                                      "Duration",
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colors.white,
                                              elevation: 10,
                                              child: Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${(visibilityWidgetsWatch.energyLog / 1000).toStringAsFixed(2)} KWh",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: ScreenUtil().setHeight(10),
                                                      width: ScreenUtil().setWidth(20),
                                                    ),
                                                    Text(
                                                      "Energy Used",
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RaisedButton(
                                      textColor: Colors.black,
                                      color: Colors.white,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Image(
                                                image: AssetImage(
                                                    AssetConstants
                                                        .resume_icon)),
                                            Padding(
                                              padding:
                                              EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              child: Text("Resume"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onPressed: () {
                                        visibilityWidgetsWatch
                                            .setIsPaused(false);
                                        visibilityWidgetsWatch
                                            .CommonRequests(8);
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ],
                                ),
                                visible: visibilityWidgetsWatch.isPausedCard(),
                              ),
                            ],
                          ),
                      ),
                    )
                    : CommonWidgets().CommonLoader(context)),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: SizedBox(
                height: ScreenUtil().setHeight(50),
                width: ScreenUtil().setWidth(200),
                child: Center(
                  child: RaisedButton(
                    textColor: Colors.black,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Constants.blue,
                          ),
                          Text("Disconnect"),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      final ConfirmAction action =
                          await _asyncConfirmDialog(context);
                      /*visibilityWidgetsWatch.socket.close();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Connection()),
                                    (Route<dynamic> route) => false);*/
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: SizedBox(width:MediaQuery.of(context).size.width,child: Text('Do you want to Disconnect?')),
          actions: <Widget>[
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Cancel);
              },
            ),
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Accept);
                visibilityWidgetsRead.responseMsgId8 = null;
                visibilityWidgetsWatch.setIsPaused(false);
                if(visibilityWidgetsWatch.socket!=null) {
                  visibilityWidgetsWatch.socket.close();
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Connection()),
                          (Route<dynamic> route) => false);
                }
              },
            )
          ],
        );
      },
    );
  }
}
