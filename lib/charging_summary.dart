import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      visibilityWidgetsRead.setappbar_name("Charging Summary");
      visibilityWidgetsRead.setSelectedIndex(0);
      visibilityWidgetsRead.setLogNumber(0);
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
    if (mounted && visibilityWidgetsWatch.responseMsgId8 != null)
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
                                        Text(
                                          "${serialNo(index)}",
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
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${(visibilityWidgetsWatch.ChargerSummaryList[index].sessionEnergy / 1000).toStringAsFixed(2)} kWh",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                                      child: Table(
                                        columnWidths: {
                                          0 : FlexColumnWidth(6),
                                          1 : FlexColumnWidth(4)
                                        },
                                        children: [
                                          TableRow(
                                              children: [
                                                Text(
                                                  "Energy",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    //fontWeight: FontWeight.bold,
                                                      color: Constants.black),
                                                ),
                                                Text(
                                                  "${(visibilityWidgetsWatch.ChargerSummaryList[index].sessionEnergy / 1000).toStringAsFixed(2)} kWh",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants.black),
                                                ),]
                                          ),
                                          TableRow(
                                              children:
                                              [
                                                Container(height: 10.h,),Container(height: 10.h,)
                                              ]
                                          ),
                                          TableRow(
                                              children: [
                                                Text(
                                                  "Mode",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    //fontWeight: FontWeight.bold,
                                                      color: Constants.black),
                                                ),
                                                Text(
                                                  "${modeLog(index)}",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants.black),
                                                ),]
                                          ),
                                          TableRow(
                                              children:
                                              [
                                                Container(height: 10.h,),Container(height: 10.h,)
                                              ]
                                          ),
                                          TableRow(
                                              children: [
                                                Text(
                                                  "Duration",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    //fontWeight: FontWeight.bold,
                                                      color: Constants.black),
                                                ),
                                                Text(
                                                  "${durationLog(visibilityWidgetsWatch.ChargerSummaryList[index].duration)}",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants.black),
                                                ),]
                                          ),
                                          TableRow(
                                              children:
                                              [
                                                Container(height: 10.h,),Container(height: 10.h,)
                                              ]
                                          ),
                                          TableRow(
                                              children: [
                                                Text(
                                                  "Completion Reason",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    //fontWeight: FontWeight.bold,
                                                      color: Constants.black),
                                                ),
                                                Text(
                                                  reasonLog(visibilityWidgetsWatch
                                                      .ChargerSummaryList[index]
                                                      .event),
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: visibilityWidgetsWatch
                                                          .ChargerSummaryList[
                                                      index]
                                                          .event ==
                                                          1 ||
                                                          visibilityWidgetsWatch
                                                              .ChargerSummaryList[
                                                          index]
                                                              .event ==
                                                              4
                                                          ? Constants.black
                                                          : Colors.black),
                                                ),]
                                          ),
                                          TableRow(
                                              children:
                                              [
                                                Container(height: 10.h,),Container(height: 10.h,)
                                              ]
                                          ),
                                          TableRow(
                                              children: [
                                                Text(
                                                  "User",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    //fontWeight: FontWeight.bold,
                                                      color: Constants.black),
                                                ),
                                                Text(
                                                  visibilityWidgetsWatch
                                                      .ChargerSummaryList[
                                                  index]
                                                      .username !=
                                                      ""
                                                      ? "${visibilityWidgetsWatch.ChargerSummaryList[index].username}"
                                                      : 'No User',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants.black),
                                                ),]
                                          )
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
                                    color: Constants.blue, fontSize: 19),
                              ),
                              onTap: () {
                                print("OccurrencesPrev ${visibilityWidgetsWatch.Occurrences}");
                                visibilityWidgetsWatch
                                    .setSelectedIndex(visibilityWidgetsWatch.selectedIndex-1);
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
                          Container(
                            height: 20,
                            width: 200,
                            child: ListView.builder(
                              itemCount: visibilityWidgetsWatch.logNumber % 5 ==
                                      0
                                  ? visibilityWidgetsWatch.TotalOccurrences
                                  : visibilityWidgetsWatch.TotalOccurrences + 1,
                              addAutomaticKeepAlives: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 10, 0),
                                  child: GestureDetector(
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                          color: visibilityWidgetsWatch
                                                      .selectedIndex ==
                                                  index
                                              ? Constants.blue
                                              : Colors.black,
                                          fontSize: 15),
                                    ),
                                    onTap: () {
                                      visibilityWidgetsWatch
                                          .setChargingSummaryLoader(true);
                                      visibilityWidgetsWatch
                                          .setSelectedIndex(index);
                                      if (visibilityWidgetsWatch.logNumber %
                                              5 ==
                                          0) {
                                        if (index == 0) {
                                          visibilityWidgetsWatch.SendRequest10(
                                              10, 1, 5);
                                          if (visibilityWidgetsWatch
                                                      .StartNumber <
                                                  1 &&
                                              visibilityWidgetsWatch.EndNumber <
                                                  5) {
                                              int difference=1-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                                print("Occurrences1 ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                          } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-1;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                                print("Occurrences1 ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                          }
                                          visibilityWidgetsWatch
                                              .setStartNumber(1);
                                          visibilityWidgetsWatch
                                              .setEndNumber(5);
                                        } else if (index == 1) {
                                          visibilityWidgetsWatch.SendRequest10(
                                              10, 6, 10);
                                          if (visibilityWidgetsWatch
                                                      .StartNumber <
                                                  6 &&
                                              visibilityWidgetsWatch.EndNumber <
                                                  10){
                                            int difference=6-visibilityWidgetsWatch.StartNumber;
                                            int gap=(difference/5).round();
                                            for(int i=0;i<gap;i++){
                                              visibilityWidgetsWatch
                                                  .setOccurrences(
                                                  visibilityWidgetsWatch
                                                      .Occurrences -
                                                      1);
                                              print("Occurrences1 ${visibilityWidgetsWatch.Occurrences}");
                                            }
                                          } else {
                                            int difference=visibilityWidgetsWatch.StartNumber-6;
                                            int gap=(difference/5).round();
                                            for(int i=0;i<gap;i++){
                                              visibilityWidgetsWatch
                                                  .setOccurrences(
                                                  visibilityWidgetsWatch
                                                      .Occurrences +
                                                      1);
                                              print("Occurrences1 ${visibilityWidgetsWatch.Occurrences}");
                                            }
                                          }
                                          visibilityWidgetsWatch
                                              .setStartNumber(6);
                                          visibilityWidgetsWatch
                                              .setEndNumber(10);
                                        } else if (index == 2) {
                                          visibilityWidgetsWatch.SendRequest10(
                                              10, 11, 15);
                                          if (visibilityWidgetsWatch
                                                      .StartNumber <
                                                  11 &&
                                              visibilityWidgetsWatch.EndNumber <
                                                  15){
                                            int difference=11-visibilityWidgetsWatch.StartNumber;
                                            int gap=(difference/5).round();
                                            for(int i=0;i<gap;i++){
                                              visibilityWidgetsWatch
                                                  .setOccurrences(
                                                  visibilityWidgetsWatch
                                                      .Occurrences -
                                                      1);
                                              print("Occurrences1 ${visibilityWidgetsWatch.Occurrences}");
                                            }
                                          } else {
                                            int difference=visibilityWidgetsWatch.StartNumber-11;
                                            int gap=(difference/5).round();
                                            for(int i=0;i<gap;i++){
                                              visibilityWidgetsWatch
                                                  .setOccurrences(
                                                  visibilityWidgetsWatch
                                                      .Occurrences +
                                                      1);
                                              print("Occurrences1 ${visibilityWidgetsWatch.Occurrences}");
                                            }
                                          }
                                          visibilityWidgetsWatch
                                              .setStartNumber(11);
                                          visibilityWidgetsWatch
                                              .setEndNumber(15);
                                        } else if (index == 3) {
                                          visibilityWidgetsWatch.SendRequest10(
                                              10, 16, 20);
                                          if (visibilityWidgetsWatch
                                                      .StartNumber <
                                                  16 &&
                                              visibilityWidgetsWatch.EndNumber <
                                                  20){
                                            int difference=16-visibilityWidgetsWatch.StartNumber;
                                            int gap=(difference/5).round();
                                            for(int i=0;i<gap;i++){
                                              visibilityWidgetsWatch
                                                  .setOccurrences(
                                                  visibilityWidgetsWatch
                                                      .Occurrences -
                                                      1);
                                            }
                                          } else {
                                            int difference=visibilityWidgetsWatch.StartNumber-16;
                                            int gap=(difference/5).round();
                                            for(int i=0;i<gap;i++){
                                              visibilityWidgetsWatch
                                                  .setOccurrences(
                                                  visibilityWidgetsWatch
                                                      .Occurrences +
                                                      1);
                                            }
                                          }
                                          visibilityWidgetsWatch
                                              .setStartNumber(16);
                                          visibilityWidgetsWatch
                                              .setEndNumber(20);
                                        } else if (index == 4) {
                                          visibilityWidgetsWatch.SendRequest10(
                                              10, 21, 25);
                                          if (visibilityWidgetsWatch
                                                      .StartNumber <
                                                  21 &&
                                              visibilityWidgetsWatch.EndNumber <
                                                  25){
                                            int difference=21-visibilityWidgetsWatch.StartNumber;
                                            int gap=(difference/5).round();
                                            for(int i=0;i<gap;i++){
                                              visibilityWidgetsWatch
                                                  .setOccurrences(
                                                  visibilityWidgetsWatch
                                                      .Occurrences -
                                                      1);
                                            }
                                          } else {
                                            int difference=visibilityWidgetsWatch.StartNumber-21;
                                            int gap=(difference/5).round();
                                            for(int i=0;i<gap;i++){
                                              visibilityWidgetsWatch
                                                  .setOccurrences(
                                                  visibilityWidgetsWatch
                                                      .Occurrences +
                                                      1);
                                            }
                                          }
                                          visibilityWidgetsWatch
                                              .setStartNumber(21);
                                          visibilityWidgetsWatch
                                              .setEndNumber(25);
                                        } else if (index == 5) {
                                          visibilityWidgetsWatch.SendRequest10(
                                              10, 26, 30);
                                          if (visibilityWidgetsWatch
                                                      .StartNumber <
                                                  26 &&
                                              visibilityWidgetsWatch.EndNumber <
                                                  30){
                                            int difference=26-visibilityWidgetsWatch.StartNumber;
                                            int gap=(difference/5).round();
                                            for(int i=0;i<gap;i++){
                                              visibilityWidgetsWatch
                                                  .setOccurrences(
                                                  visibilityWidgetsWatch
                                                      .Occurrences -
                                                      1);
                                            }
                                          } else {
                                            int difference=visibilityWidgetsWatch.StartNumber-26;
                                            int gap=(difference/5).round();
                                            for(int i=0;i<gap;i++){
                                              visibilityWidgetsWatch
                                                  .setOccurrences(
                                                  visibilityWidgetsWatch
                                                      .Occurrences +
                                                      1);
                                            }
                                          }
                                          visibilityWidgetsWatch
                                              .setStartNumber(26);
                                          visibilityWidgetsWatch
                                              .setEndNumber(30);
                                        }
                                      } else {
                                        if (index == 0) {
                                          if (visibilityWidgetsWatch.logNumber <
                                              5) {
                                            visibilityWidgetsWatch
                                                .SendRequest10(
                                                    10,
                                                    1,
                                                    visibilityWidgetsWatch
                                                        .logNumber);
                                            if (visibilityWidgetsWatch
                                                        .StartNumber <
                                                    1 &&
                                                visibilityWidgetsWatch
                                                        .EndNumber <
                                                    visibilityWidgetsWatch
                                                        .logNumber){
                                              int difference=1-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                                print("Occurrences ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                            } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-1;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                                print("Occurrences ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                            }
                                            visibilityWidgetsWatch
                                                .setStartNumber(1);
                                            visibilityWidgetsWatch.setEndNumber(
                                                visibilityWidgetsWatch
                                                    .logNumber);
                                          } else {
                                            visibilityWidgetsWatch
                                                .SendRequest10(10, 1, 5);
                                            if (visibilityWidgetsWatch
                                                        .StartNumber <
                                                    1 &&
                                                visibilityWidgetsWatch
                                                        .EndNumber <
                                                    5){
                                              int difference=1-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                                print("Occurrences ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                            } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-1;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                                print("Occurrences ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                            }
                                            visibilityWidgetsWatch
                                                .setStartNumber(1);
                                            visibilityWidgetsWatch
                                                .setEndNumber(5);
                                          }
                                        } else if (index == 1) {
                                          if (visibilityWidgetsWatch.logNumber <
                                              10) {
                                            visibilityWidgetsWatch
                                                .SendRequest10(
                                                    10,
                                                    6,
                                                    visibilityWidgetsWatch
                                                        .logNumber);
                                            if (visibilityWidgetsWatch
                                                        .StartNumber <
                                                    6 &&
                                                visibilityWidgetsWatch
                                                        .EndNumber <
                                                    visibilityWidgetsWatch
                                                        .logNumber){
                                              int difference=6-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                                print("Occurrences ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                            } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-6;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                                print("Occurrences ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                            }
                                            visibilityWidgetsWatch
                                                .setStartNumber(6);
                                            visibilityWidgetsWatch.setEndNumber(
                                                visibilityWidgetsWatch
                                                    .logNumber);
                                          } else {
                                            visibilityWidgetsWatch
                                                .SendRequest10(10, 6, 10);
                                            if (visibilityWidgetsWatch
                                                        .StartNumber <
                                                    6 &&
                                                visibilityWidgetsWatch
                                                        .EndNumber <
                                                    10){
                                              int difference=6-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                                print("Occurrences ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                            } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-6;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                                print("Occurrences ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                            }
                                            visibilityWidgetsWatch
                                                .setStartNumber(6);
                                            visibilityWidgetsWatch
                                                .setEndNumber(10);
                                          }
                                        } else if (index == 2) {
                                          if (visibilityWidgetsWatch.logNumber <
                                              15) {
                                            visibilityWidgetsWatch
                                                .SendRequest10(
                                                    10,
                                                    11,
                                                    visibilityWidgetsWatch
                                                        .logNumber);
                                            if (visibilityWidgetsWatch
                                                        .StartNumber <
                                                    11 &&
                                                visibilityWidgetsWatch
                                                        .EndNumber <
                                                    visibilityWidgetsWatch
                                                        .logNumber){
                                              int difference=11-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                                print("Occurrences ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                            } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-11;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                                print("Occurrences ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                            }
                                            visibilityWidgetsWatch
                                                .setStartNumber(11);
                                            visibilityWidgetsWatch.setEndNumber(
                                                visibilityWidgetsWatch
                                                    .logNumber);
                                          } else {
                                            visibilityWidgetsWatch
                                                .SendRequest10(10, 11, 15);
                                            if (visibilityWidgetsWatch
                                                        .StartNumber <
                                                    11 &&
                                                visibilityWidgetsWatch
                                                        .EndNumber <
                                                    15){
                                              int difference=11-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                                print("Occurrences ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                            } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-11;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                                print("Occurrences ${visibilityWidgetsWatch.Occurrences}");
                                              }
                                            }
                                            visibilityWidgetsWatch
                                                .setStartNumber(11);
                                            visibilityWidgetsWatch
                                                .setEndNumber(15);
                                          }
                                        } else if (index == 3) {
                                          if (visibilityWidgetsWatch.logNumber <
                                              20) {
                                            visibilityWidgetsWatch
                                                .SendRequest10(
                                                    10,
                                                    16,
                                                    visibilityWidgetsWatch
                                                        .logNumber);
                                            if (visibilityWidgetsWatch
                                                        .StartNumber <
                                                    16 &&
                                                visibilityWidgetsWatch
                                                        .EndNumber <
                                                    visibilityWidgetsWatch
                                                        .logNumber){
                                              int difference=16-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                              }
                                            } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-16;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                              }
                                            }
                                            visibilityWidgetsWatch
                                                .setStartNumber(16);
                                            visibilityWidgetsWatch.setEndNumber(
                                                visibilityWidgetsWatch
                                                    .logNumber);
                                          } else {
                                            visibilityWidgetsWatch
                                                .SendRequest10(10, 16, 20);
                                            if (visibilityWidgetsWatch
                                                        .StartNumber <
                                                    16 &&
                                                visibilityWidgetsWatch
                                                        .EndNumber <
                                                    20){
                                              int difference=16-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                              }
                                            } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-16;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                              }
                                            }
                                            visibilityWidgetsWatch
                                                .setStartNumber(16);
                                            visibilityWidgetsWatch
                                                .setEndNumber(20);
                                          }
                                        } else if (index == 4) {
                                          if (visibilityWidgetsWatch.logNumber <
                                              25) {
                                            visibilityWidgetsWatch
                                                .SendRequest10(
                                                    10,
                                                    21,
                                                    visibilityWidgetsWatch
                                                        .logNumber);
                                            if (visibilityWidgetsWatch
                                                        .StartNumber <
                                                    21 &&
                                                visibilityWidgetsWatch
                                                        .EndNumber <
                                                    visibilityWidgetsWatch
                                                        .logNumber){
                                              int difference=21-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                              }
                                            } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-21;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                              }
                                            }
                                            visibilityWidgetsWatch
                                                .setStartNumber(21);
                                            visibilityWidgetsWatch.setEndNumber(
                                                visibilityWidgetsWatch
                                                    .logNumber);
                                          } else {
                                            visibilityWidgetsWatch
                                                .SendRequest10(10, 21, 25);
                                            if (visibilityWidgetsWatch
                                                        .StartNumber <
                                                    21 &&
                                                visibilityWidgetsWatch
                                                        .EndNumber <
                                                    25){
                                              int difference=21-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                              }
                                            } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-21;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                              }
                                            }
                                            visibilityWidgetsWatch
                                                .setStartNumber(21);
                                            visibilityWidgetsWatch
                                                .setEndNumber(25);
                                          }
                                        } else if (index == 5) {
                                          if (visibilityWidgetsWatch.logNumber <
                                              30) {
                                            visibilityWidgetsWatch
                                                .SendRequest10(
                                                    10,
                                                    26,
                                                    visibilityWidgetsWatch
                                                        .logNumber);
                                            if (visibilityWidgetsWatch
                                                        .StartNumber <
                                                    26 &&
                                                visibilityWidgetsWatch
                                                        .EndNumber <
                                                    visibilityWidgetsWatch
                                                        .logNumber){
                                              int difference=26-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                              }
                                            } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-26;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                              }
                                            }
                                            visibilityWidgetsWatch
                                                .setStartNumber(26);
                                            visibilityWidgetsWatch.setEndNumber(
                                                visibilityWidgetsWatch
                                                    .logNumber);
                                          } else {
                                            visibilityWidgetsWatch
                                                .SendRequest10(10, 26, 30);
                                            if (visibilityWidgetsWatch
                                                        .StartNumber <
                                                    26 &&
                                                visibilityWidgetsWatch
                                                        .EndNumber <
                                                    30){
                                              int difference=26-visibilityWidgetsWatch.StartNumber;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences -
                                                        1);
                                              }
                                            } else {
                                              int difference=visibilityWidgetsWatch.StartNumber-26;
                                              int gap=(difference/5).round();
                                              for(int i=0;i<gap;i++){
                                                visibilityWidgetsWatch
                                                    .setOccurrences(
                                                    visibilityWidgetsWatch
                                                        .Occurrences +
                                                        1);
                                              }
                                            }
                                            visibilityWidgetsWatch
                                                .setStartNumber(26);
                                            visibilityWidgetsWatch
                                                .setEndNumber(30);
                                          }
                                        }
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Visibility(
                            child: GestureDetector(
                              child: Text(
                                "NEXT>>",
                                style: TextStyle(
                                    color: Constants.blue, fontSize: 19),
                              ),
                              onTap: () {
                                print("OccurrencesNext ${visibilityWidgetsWatch.Occurrences}");
                                visibilityWidgetsWatch
                                    .setSelectedIndex(visibilityWidgetsWatch.selectedIndex+1);
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
                                    //visibilityWidgetsWatch.setEndNumber(visibilityWidgetsWatch.StartNumber - 1);
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
          :  Center(
              child: Text(
                "No Value",
                style: TextStyle(
                    color: Constants.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
    );
  }

  String timeLog(int time) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm:ss aa');
    return formatter.format(DateTime.fromMillisecondsSinceEpoch((time) * 1000));
  }

  String modeLog(int index) {
    if (visibilityWidgetsWatch.ChargerSummaryList[index].mode == 1 ||
        visibilityWidgetsWatch.ChargerSummaryList[index].mode == 6)
      return "Manual";
    else if (visibilityWidgetsWatch.ChargerSummaryList[index].mode == 2 ||
        visibilityWidgetsWatch.ChargerSummaryList[index].mode == 7)
      return "Schedule";
    else
      return "Other";
  }

  String durationLog(int duration) {
    int secLog = duration % 60;
    int minuteLog = ((duration / 60) % 60).floor();
    int hourLog = ((duration / 60) / 60).floor();
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

  int serialNo(int index) {
    if (index == 0) {
      return visibilityWidgetsWatch.StartNumber;
    } else if (index == 1) {
      return visibilityWidgetsWatch.StartNumber + 1;
    } else if (index == 2) {
      return visibilityWidgetsWatch.StartNumber + 2;
    } else if (index == 3) {
      return visibilityWidgetsWatch.StartNumber + 3;
    } else if (index == 4) {
      return visibilityWidgetsWatch.StartNumber + 4;
    }
  }
}
