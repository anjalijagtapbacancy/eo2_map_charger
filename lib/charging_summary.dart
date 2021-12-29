import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

import 'CommonWidgets.dart';
import 'ConstantFunction/Constants.dart';
import 'VisibilityWidgets.dart';

class ChargingSummary extends StatefulWidget {
  ChargingSummary();

  @override
  charging_summary_state createState() => charging_summary_state();
}

class charging_summary_state extends State<ChargingSummary> {
  List<bool> isExpandView = new List();
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;

  // bool isExpandView=false;

  //ResponseMsgId10 responseMsgId10;

  String img = AssetConstants.ic_arrow_down;

  charging_summary_state();

  @override
  Future<void> initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
      visibilityWidgetsRead.CommonRequests(16);
      visibilityWidgetsRead.setChargingSummaryLoader(true);
      visibilityWidgetsRead.setCurrentLog(false);
      visibilityWidgetsRead.setStartNumber(-4);
      visibilityWidgetsRead.setEndNumber(1);
      SendFirstRequest();
    });
  }

  Future<void> SendFirstRequest() async {
    await Future.delayed(Duration(seconds: 2));
    if (visibilityWidgetsRead.logNumber != 0) {
      visibilityWidgetsRead
          .setTotalOccurrences((visibilityWidgetsRead.logNumber / 5).floor());
      visibilityWidgetsRead
          .setOccurrences(visibilityWidgetsRead.TotalOccurrences);
      visibilityWidgetsRead
          .setOccurrences(visibilityWidgetsRead.Occurrences - 1);
      visibilityWidgetsRead
          .setStartNumber(visibilityWidgetsRead.StartNumber + 5);
      if (visibilityWidgetsRead.logNumber <= 5) {
        visibilityWidgetsRead.setEndNumber(visibilityWidgetsRead.logNumber);
      } else {
        visibilityWidgetsRead
            .setEndNumber(visibilityWidgetsRead.StartNumber + 4);
      }
      visibilityWidgetsRead.SendRequest10(10, visibilityWidgetsRead.StartNumber,
          visibilityWidgetsRead.EndNumber);
    }
    await Future.delayed(Duration(seconds: 3));
    if (visibilityWidgetsRead.logNumber == 0) {
      visibilityWidgetsRead.setChargerSummaryList(null);
      //recyChargerSummary.setVisibility(View.GONE);
      //tv_no_value.setVisibility(View.VISIBLE);
      /*  if (alertDialog_summary != null)
        alertDialog_summary.dismiss();*/
    }
  }

  Widget arrowUpDown(bool isExpandView) {
    if (isExpandView) {
      return Image(image: AssetImage(AssetConstants.ic_arrow_up));
    } else {
      return Image(image: AssetImage(AssetConstants.ic_arrow_down));
    }
  }

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    if(mounted && visibilityWidgetsWatch.responseMsgId8 != null)
      visibilityWidgetsWatch.Network(context);
    return Scaffold(
      body: visibilityWidgetsWatch.ChargerSummaryList != null
          ? visibilityWidgetsWatch.ChargingSummaryLoader == false
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            visibilityWidgetsWatch.ChargerSummaryList.length,
                        addAutomaticKeepAlives: true,
                        itemBuilder: (context, index) {
                          for (int i = 0;
                              i <
                                  visibilityWidgetsWatch
                                      .ChargerSummaryList.length;
                              i++) {
                            isExpandView.add(false);
                          }
                          // return SelectContainer(
                          //     chargerSummary:
                          //         responseMsgId10.properties.array[index]);
                          return Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Time",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          // timeLog(chargerSummary.time),
                                          timeLog(visibilityWidgetsWatch
                                              .ChargerSummaryList[index].time),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (isExpandView[index]) {
                                                  isExpandView[index] = false;
                                                } else {
                                                  isExpandView[index] = true;
                                                }
                                              });
                                              // when it is pressed
                                            },
                                            child: arrowUpDown(isExpandView[
                                                index]), /*Image(
                        image: AssetImage(img)*/
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Energy",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                "${(visibilityWidgetsWatch.ChargerSummaryList[index].sessionEnergy / 1000).toStringAsFixed(2)} kWh",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Mode",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                modeLog(
                                                    visibilityWidgetsWatch
                                                        .ChargerSummaryList[
                                                            index]
                                                        .mode,
                                                    index),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Duration",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                durationLog(
                                                    visibilityWidgetsWatch
                                                        .ChargerSummaryList[
                                                            index]
                                                        .duration),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Completion Reason",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                reasonLog(visibilityWidgetsWatch
                                                    .ChargerSummaryList[index]
                                                    .event),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    visible: isExpandView[index],
                                  ),
                                  Container(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Visibility(
                            child: GestureDetector(
                              child: Text(
                                "<<PREV",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 19),
                              ),
                              onTap: () {
                                visibilityWidgetsWatch
                                    .setChargingSummaryLoader(true);
                                if (visibilityWidgetsWatch.logNumber % 5 == 0) {
                                  if (visibilityWidgetsWatch.StartNumber > 1) {
                                    visibilityWidgetsWatch.setOccurrences(
                                        visibilityWidgetsWatch.Occurrences + 1);
                                    visibilityWidgetsWatch.setEndNumber(
                                        visibilityWidgetsWatch.EndNumber -
                                            5); //10 5
                                    visibilityWidgetsWatch.setStartNumber(
                                        visibilityWidgetsWatch.StartNumber -
                                            5); //6 1
                                    visibilityWidgetsWatch.SendRequest10(
                                        10,
                                        visibilityWidgetsWatch.StartNumber,
                                        visibilityWidgetsWatch.EndNumber);
                                  }
                                } else {
                                  if (visibilityWidgetsWatch.Occurrences ==
                                      -1) {
                                    visibilityWidgetsWatch.setOccurrences(
                                        visibilityWidgetsWatch.Occurrences + 1);
                                    visibilityWidgetsWatch.setEndNumber(
                                        visibilityWidgetsWatch.StartNumber -
                                            1); //10 5
                                    visibilityWidgetsWatch.setStartNumber(
                                        visibilityWidgetsWatch.StartNumber -
                                            5); //6 1
                                    visibilityWidgetsWatch.SendRequest10(
                                        10,
                                        visibilityWidgetsWatch.StartNumber,
                                        visibilityWidgetsWatch.EndNumber);
                                  } else if (visibilityWidgetsWatch
                                          .Occurrences <
                                      visibilityWidgetsWatch.TotalOccurrences) {
                                    visibilityWidgetsWatch.setOccurrences(
                                        visibilityWidgetsWatch.Occurrences + 1);
                                    visibilityWidgetsWatch.setEndNumber(
                                        visibilityWidgetsWatch.EndNumber -
                                            5); //10 5
                                    visibilityWidgetsWatch.setStartNumber(
                                        visibilityWidgetsWatch.StartNumber -
                                            5); //6 1
                                    visibilityWidgetsWatch.SendRequest10(
                                        10,
                                        visibilityWidgetsWatch.StartNumber,
                                        visibilityWidgetsWatch.EndNumber);
                                  }
                                }
                                setState(() {
                                  isExpandView.clear();
                                });
                              },
                            ),
                            visible: visibilityWidgetsWatch.isTextprev() != null
                                ? visibilityWidgetsWatch.isTextprev()
                                : false,
                          ),
                          Visibility(
                            child: GestureDetector(
                              child: Text(
                                "NEXT>>",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 19),
                              ),
                              onTap: () {
                                visibilityWidgetsWatch
                                    .setChargingSummaryLoader(true);
                                if (visibilityWidgetsWatch.logNumber % 5 == 0) {
                                  if (visibilityWidgetsWatch.EndNumber <
                                      visibilityWidgetsWatch.logNumber) {
                                    visibilityWidgetsWatch.setOccurrences(
                                        visibilityWidgetsWatch.Occurrences - 1);
                                    visibilityWidgetsWatch.setStartNumber(
                                        visibilityWidgetsWatch.StartNumber +
                                            5); //6 11 16
                                    visibilityWidgetsWatch.setEndNumber(
                                        visibilityWidgetsWatch.StartNumber +
                                            4); //10  15 20
                                    visibilityWidgetsWatch.SendRequest10(
                                        10,
                                        visibilityWidgetsWatch.StartNumber,
                                        visibilityWidgetsWatch.EndNumber);
                                  }
                                } else {
                                  if (visibilityWidgetsWatch.Occurrences > 0) {
                                    visibilityWidgetsWatch.setOccurrences(
                                        visibilityWidgetsWatch.Occurrences -
                                            1); //3 2 1 0
                                    visibilityWidgetsWatch.setStartNumber(
                                        visibilityWidgetsWatch.StartNumber +
                                            5); //1 6 11 16
                                    visibilityWidgetsWatch.setEndNumber(
                                        visibilityWidgetsWatch.StartNumber +
                                            4); //5 10  15 20
                                    visibilityWidgetsWatch.SendRequest10(
                                        10,
                                        visibilityWidgetsWatch.StartNumber,
                                        visibilityWidgetsWatch.EndNumber);
                                  } else if (visibilityWidgetsWatch
                                          .Occurrences ==
                                      0) {
                                    visibilityWidgetsWatch.setOccurrences(
                                        visibilityWidgetsWatch.Occurrences - 1);
                                    visibilityWidgetsWatch.setStartNumber(
                                        visibilityWidgetsWatch.StartNumber +
                                            5); //21
                                    visibilityWidgetsWatch.setEndNumber(
                                        visibilityWidgetsWatch.logNumber); //23
                                    visibilityWidgetsWatch.SendRequest10(
                                        10,
                                        visibilityWidgetsWatch.StartNumber,
                                        visibilityWidgetsWatch.EndNumber);
                                    visibilityWidgetsWatch.setEndNumber(
                                        visibilityWidgetsWatch.StartNumber - 1);
                                  }
                                }
                                setState(() {
                                  isExpandView.clear();
                                });
                              },
                            ),
                            visible: visibilityWidgetsWatch.isTextNext() != null
                                ? visibilityWidgetsWatch.isTextNext()
                                : false,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : CommonWidgets().CommonLoader(context)
          : const Center(
              child: Text(
                "No Value",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
    );
  }

  String timeLog(int time) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss aa');
    return formatter.format(DateTime.fromMillisecondsSinceEpoch((time) * 1000));
  }

  String modeLog(int mode, int index) {
    if (visibilityWidgetsWatch.ChargerSummaryList[index].mode == 1 ||
        visibilityWidgetsWatch.ChargerSummaryList[index].mode == 6)
      return "Manual";
    else if (visibilityWidgetsWatch.ChargerSummaryList[index].mode == 2 ||
        visibilityWidgetsWatch.ChargerSummaryList[index].mode == 7)
      return "Schedule";
    else
      return "-Manual";
  }

  String durationLog(int duration) {
    int secLog = duration % 60;
    int minuteLog = ((duration / 60) % 60).round();
    int hourLog = ((duration / 60) / 60).round();
    String durationlog =
        sprintf("%02d:%02d:%02d", [hourLog, minuteLog, secLog]);
    return durationlog;
  }

  String reasonLog(int event) {
    if (event == 1) {
      return "Full Charged";
    } else if (event == 2) {
      return "Gun Removed";
    } else if (event == 3) {
      return "Fault Occurred";
    } else if (event == 4) {
      return "Manual Stop";
    } else if (event == 5) {
      return "Power Loss";
    } else if (event == 6) {
      return "Charging Start";
    } else if (event == 7) {
      return "Other";
    } else if (event == 8) {
      return "OverCurrent";
    } else if (event == 9) {
      return "OverVoltage";
    } else if (event == 10) {
      return "UnderVoltage";
    } else if (event == 11) {
      return "Emergency Stop";
    }
  }
}
