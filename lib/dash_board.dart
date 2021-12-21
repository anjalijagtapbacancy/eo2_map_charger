import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprintf/sprintf.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'CommonWidgets.dart';
import 'package:connectivity/connectivity.dart';
import 'Connection.dart';
import 'ConstantFunction/Constants.dart';
import 'VisibilityWidgets.dart';
import 'ev_analysis.dart';

class DashBoard extends StatefulWidget {
  @override
  dashboard_state createState() => dashboard_state();

  DashBoard();
}

enum ConfirmAction { Cancel, Accept }

class dashboard_state extends State<DashBoard>
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

      visibilityWidgetsRead.setCurrentLog(true);
      visibilityWidgetsRead.setisResponse8(false);
      Future.delayed(
        Duration(seconds: 7),
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

      // subscription = Connectivity()
      //     .onConnectivityChanged
      //     .listen((ConnectivityResult result) {
      //       if(visibilityWidgetsRead.socket!=null) {
      //         visibilityWidgetsRead.socket.close();
      //         Navigator.of(context).pushAndRemoveUntil(
      //             MaterialPageRoute(builder: (context) => Connection()),
      //                 (Route<dynamic> route) => false);
      //       }
      // });
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
    linearAnimationController.dispose();
    //subscription.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 255, 229, 1),
      body:
          visibilityWidgetsWatch.responseMsgId8 != null &&
                  visibilityWidgetsWatch.readyLoader == false &&
                  visibilityWidgetsWatch.stopLoader == false
              ? Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                  image: AssetImage(
                                      AssetConstants.charging_gun_icon)),
                              Text(
                                "   Device Id: \n${visibilityWidgetsWatch.device_id}",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 5,
                                height: 5,
                              ),
                              RaisedButton(
                                textColor: Colors.black,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: const [
                                      Image(
                                        image: AssetImage(
                                            AssetConstants.ic_ev_analysis),
                                        color: Colors.grey,
                                        width: 30,
                                        height: 25,
                                      ),
                                      Text("Ev Analysis"),
                                    ],
                                  ),
                                ),
                                onPressed: () {
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
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.white,
                                elevation: 10,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Visibility(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "${visibilityWidgetsWatch.Tips()}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              wordSpacing: 1.0,
                                              color: Colors.black),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      visible: visibilityWidgetsWatch.isTip(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 15, 0, 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Visibility(
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  final pref =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  visibilityWidgetsWatch
                                                      .setStartHour((pref.getInt(
                                                                  'startHour') !=
                                                              null)
                                                          ? pref.getInt(
                                                              'startHour')
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
                                                          ? pref
                                                              .getInt('endHour')
                                                          : 00);
                                                  visibilityWidgetsWatch
                                                      .setEndMinute((pref.getInt(
                                                                  'endMinute') !=
                                                              null)
                                                          ? pref.getInt(
                                                              'endMinute')
                                                          : 00);
                                                  visibilityWidgetsWatch
                                                      .setisScheduling((pref
                                                                  .getBool(
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
                                                            color:
                                                                Color.fromRGBO(
                                                                    242,
                                                                    255,
                                                                    229,
                                                                    1),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
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
                                                                    const Text(
                                                                      'Schedule Charging',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .all(
                                                                          10.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            "Scheduling",
                                                                            style: TextStyle(
                                                                                fontSize: 19,
                                                                                color: Colors.green,
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
                                                                                Colors.green,
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
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                GestureDetector(
                                                                              child: Card(
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
                                                                                        height: 20,
                                                                                        width: 20,
                                                                                      ),
                                                                                      Text(
                                                                                        "Start of Charging",
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              onTap: () async {
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
                                                                              child: Card(
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
                                                                                        height: 20,
                                                                                        width: 20,
                                                                                      ),
                                                                                      Text(
                                                                                        "End of Charging",
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              onTap: () async {
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
                                                                    Container(
                                                                      height:
                                                                          200,
                                                                      width:
                                                                          200,
                                                                      child: SfRadialGauge(
                                                                          axes: <
                                                                              RadialAxis>[
                                                                            RadialAxis(
                                                                              axisLineStyle: AxisLineStyle(
                                                                                color: Colors.grey,
                                                                                thickness: 0.2,
                                                                                thicknessUnit: GaugeSizeUnit.factor,
                                                                              ),
                                                                              startAngle: 270,
                                                                              maximum: 1440,
                                                                              endAngle: 270,
                                                                              minimum: 0,
                                                                              showLabels: false,
                                                                              showTicks: false,
                                                                              pointers: <GaugePointer>[
                                                                                RangePointer(
                                                                                  value: visibilityWidgetsWatch.timeDiffernce(),
                                                                                  width: 0.2,
                                                                                  enableAnimation: true,
                                                                                  sizeUnit: GaugeSizeUnit.factor,
                                                                                  gradient: const SweepGradient(colors: <Color>[
                                                                                    Color.fromARGB(242, 147, 250, 151),
                                                                                    Color.fromARGB(242, 82, 222, 88),
                                                                                    Color.fromARGB(242, 48, 191, 54),
                                                                                    Color.fromARGB(242, 16, 145, 21)
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
                                                                                      SizedBox(
                                                                                        width: 13,
                                                                                        height: 5,
                                                                                      ),
                                                                                      Text(
                                                                                        sprintf('%2d:%02d', [
                                                                                          visibilityWidgetsWatch.hour_diff,
                                                                                          visibilityWidgetsWatch.min_diff
                                                                                        ]),
                                                                                        style: TextStyle(color: Colors.green, fontSize: 19),
                                                                                      ),
                                                                                    ],
                                                                                  ),
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
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              width: 100,
                                                                              child: Center(
                                                                                child: Text("Cancel", style: TextStyle(fontSize: 15)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
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
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
                                                                              width: 100,
                                                                              child: Center(
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
                                                                            int maxCurrent =
                                                                                [
                                                                              6,
                                                                              10,
                                                                              15,
                                                                              18,
                                                                              24,
                                                                              30
                                                                            ][visibilityWidgetsWatch.currentMax.round()];
                                                                            visibilityWidgetsWatch.SendRequest2(
                                                                                2,
                                                                                visibilityWidgetsWatch.isScheduling,
                                                                                wdStartTime,
                                                                                wdEndTime,
                                                                                1,
                                                                                1,
                                                                                maxCurrent);
                                                                            Navigator.pop(context);
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
                                                  image: AssetImage(
                                                      AssetConstants
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
                                                width: 170,
                                                height: 170,
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
                                                      .setReadyLoader(true);
                                                  visibilityWidgetsWatch
                                                      .SendRequest3(3, 1);
                                                  await Future.delayed(
                                                      Duration(seconds: 1));
                                                  visibilityWidgetsWatch
                                                      .CommonRequests(8);
                                                },
                                                child: Container(
                                                  width: 170,
                                                  height: 170,
                                                  decoration: new BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        242, 255, 229, 1),
                                                    shape: BoxShape.circle,
                                                    border: new Border.all(
                                                      color: Colors.green,
                                                      width: 15,
                                                    ),
                                                  ),
                                                  child: new Center(
                                                    child: new Text(
                                                      'Ready',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.green,
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
                                            child: Container(
                                              width: 70,
                                              height: 70,
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
                                                          child: Container(
                                                            height: 300,
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
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                Slider(
                                                                  value: visibilityWidgetsWatch
                                                                      .currentMax
                                                                      .toDouble(),
                                                                  min: 0,
                                                                  max: 5,
                                                                  divisions: 5,
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
                                                                      Colors
                                                                          .green,
                                                                  onChanged:
                                                                      (double
                                                                          value) {
                                                                    setState(
                                                                        () {
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
                                                                      Text(
                                                                          "Slow",
                                                                          style: TextStyle(
                                                                              color: Colors.green,
                                                                              fontSize: 15)),
                                                                      Text(
                                                                          "Moderate",
                                                                          style: TextStyle(
                                                                              color: Colors.green,
                                                                              fontSize: 15)),
                                                                      Text(
                                                                          "Fast",
                                                                          style: TextStyle(
                                                                              color: Colors.green,
                                                                              fontSize: 15)),
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
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text("Cancel", style: TextStyle(fontSize: 15)),
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
                                                                          Colors
                                                                              .black,
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text("Set", style: TextStyle(fontSize: 15)),
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
                                                                            ][visibilityWidgetsWatch.currentMax.round()]);
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
                                                        );
                                                      });
                                                    },
                                                  );
                                                },
                                                child: Image(
                                                  image: AssetImage(
                                                      AssetConstants
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
                                      height: 10,
                                    ),
                                    Visibility(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          sprintf(
                                              'You charged last at %s by %s Charging time was %02d:%02d:%02d with energy used %.2f KWh.',
                                              [
                                                visibilityWidgetsWatch.timeLog,
                                                visibilityWidgetsWatch.modLog,
                                                visibilityWidgetsWatch.hourLog,
                                                visibilityWidgetsWatch
                                                    .minuteLog,
                                                visibilityWidgetsWatch.secLog,
                                                visibilityWidgetsWatch
                                                        .energyLog /
                                                    1000
                                              ]),
                                          style: TextStyle(
                                            fontSize: 17,
                                            wordSpacing: 1.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      visible: visibilityWidgetsWatch
                                          .isChargingTxt(),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Visibility(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          sprintf(
                                              'Your Next Charging will be at %02d:%02d.',
                                              [
                                                visibilityWidgetsWatch
                                                    .startHour,
                                                visibilityWidgetsWatch
                                                    .startMinute
                                              ]),
                                          style: TextStyle(
                                              fontSize: 17, wordSpacing: 0.5),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      visible: visibilityWidgetsWatch
                                          .isNextChargingTxt(),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            visible: visibilityWidgetsWatch.isReadyCard(),
                          ),
                          Visibility(
                            child: Column(
                              children: [
                                Text(
                                  "EV Connected",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Colors.white,
                                    elevation: 10,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 15, 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: SizedBox(height: 15)),
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
                                                          width: 15,
                                                          height: 15,
                                                          child: Container(
                                                            color: Colors.red,
                                                          )),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                5, 0, 0, 0),
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
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 290,
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
                                                      children: const [
                                                        AspectRatio(
                                                          aspectRatio: 7,
                                                          child: Image(
                                                            image: AssetImage(
                                                              AssetConstants
                                                                  .flash_charging,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Charging",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 15),
                                                        )
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
                                                      color: Colors.green)
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
                                                offsetUnit:
                                                    GaugeSizeUnit.factor,
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
                                                  "${(visibilityWidgetsWatch.charging_current / 1000).toStringAsFixed(2)} A",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                  width: 20,
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
                                                  "${(visibilityWidgetsWatch.charging_voltage / 100).toStringAsFixed(2)} V",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  width: 20,
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
                                                  "${(visibilityWidgetsWatch.charging_power / 1000).toStringAsFixed(2)} KW",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Charging Power",
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
                                                  "${(visibilityWidgetsWatch.overall_energy / 1000).toStringAsFixed(2)} KWh",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                const Text(
                                                  "Charging Energy",
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
                            ),
                            visible: visibilityWidgetsWatch.isChargingCard(),
                          ),
                          Visibility(
                            child: Column(
                              children: [
                                Text(
                                  "EV Connected",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color: Colors.white,
                                    elevation: 10,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: SizedBox()),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 5, 0),
                                              child: RaisedButton(
                                                textColor: Colors.black,
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 280,
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
                                                      children: const [
                                                        AspectRatio(
                                                          aspectRatio: 7,
                                                          child: Image(
                                                            image: AssetImage(
                                                              AssetConstants
                                                                  .flash_charging,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "  Paused\nCharging",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 20),
                                                        )
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
                                                      value: 360,
                                                      width: 0.05,
                                                      sizeUnit:
                                                          GaugeSizeUnit.factor,
                                                      color: Colors.green)
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
                                                offsetUnit:
                                                    GaugeSizeUnit.factor,
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
                                                  height: 5,
                                                  width: 5,
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
                                                  "${visibilityWidgetsWatch.modLog}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  width: 20,
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
                                  padding: const EdgeInsets.all(15.0),
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
                                                  height: 20,
                                                  width: 20,
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
                                                  height: 20,
                                                  width: 20,
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
                              ],
                            ),
                            visible: visibilityWidgetsWatch.isPausedCard(),
                          ),
                        ],
                      ),
                    )),
                    Container(
                      height: 60,
                      width: 200,
                      child: Center(
                        child: RaisedButton(
                          textColor: Colors.black,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.green,
                                ),
                                Text("Back"),
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
                  ],
                )
              : CommonWidgets().CommonLoader(context),
    );
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you want to Exit'),
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
                visibilityWidgetsWatch.setIsPaused(false);
                visibilityWidgetsWatch.socket.close();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
