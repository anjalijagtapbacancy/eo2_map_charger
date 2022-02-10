import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'CommonWidgets.dart';
import 'ConstantFunction/size_constants.dart';
import 'VisibilityWidgets.dart';

class EvAnalysis extends StatefulWidget {
  EvAnalysis();

  @override
  ev_analysis_state createState() => ev_analysis_state();
}

class ev_analysis_state extends State<EvAnalysis>
    with SingleTickerProviderStateMixin {
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;
  TabController _tabController;


  ev_analysis_state();

//[WeekEnergy(33, "Mon")]
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    SendSecondRequest();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
      visibilityWidgetsRead.setEvAnalysisLoader(true);
      /*visibilityWidgetsRead.getWeekData();
      visibilityWidgetsRead.getMonthData();
      visibilityWidgetsRead.getYearData();*/
    });
    super.initState();
  }

  Future<void> SendSecondRequest() async {
    await Future.delayed(Duration(seconds: 1));
    visibilityWidgetsWatch.SendRequest12(12, 2);
    await Future.delayed(Duration(seconds: 3));
    visibilityWidgetsWatch.SendRequest12(12, 3);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    visibilityWidgetsWatch.ClearLists();
  }

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    SizeConstants.setScreenAwareConstant(context);
    if(mounted && visibilityWidgetsWatch.responseMsgId8 != null)
      visibilityWidgetsWatch.Network(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ev Analysis",style: TextStyle(color: Colors.green,),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color:Colors.green ),
      ),
      body: visibilityWidgetsWatch.EvAnalysisLoader == false
          ? Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
            child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 4, 0),
            child: Container(
              height: 45,//45
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TabBar(
                  indicatorColor: Colors.green,
                  controller: _tabController,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(
                      text: 'Week',
                    ),
                    Tab(
                      text: '30 Days',
                    ),
                    Tab(
                      text: '1 Year',
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height:ScreenUtil().setHeight(20),
          ),
          // tab bar view here
           Padding(
             padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
             child: Container(
               color: Colors.white,
               height: ScreenUtil().setHeight(500),
               width: MediaQuery.of(context).size.width,
               child: Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: TabBarView(
                    controller: _tabController,
                    children: [
                      // first tab bar view widget
                      Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Total Consumption',style:TextStyle(fontSize: 20.sp,color: Colors.grey)),
                                Text('${visibilityWidgetsWatch.totalConsumptionWeek} kWh',style:TextStyle(fontSize: 24.sp,color: Colors.black)),
                                Text('Energy (kWh)',style:TextStyle(fontSize: 14.sp,color: Colors.grey)),
                                SizedBox(height: ScreenUtil().setHeight(10),),
                                Container(
                                  height: ScreenUtil().setHeight(350),
                                  child: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(
                                        arrangeByIndex: true,
                                        desiredIntervals: 7,
                                        majorGridLines: MajorGridLines(color:Colors.transparent,),
                                      ),
                                      primaryYAxis: NumericAxis(
                                        //title: AxisTitle(text:"Energy (kWh)",textStyle: TextStyle(fontSize: 14.sp)),
                                        labelFormat: '{value}',
                                      ),
                                      series: <ColumnSeries<WeekEnergy, String>>[
                                        ColumnSeries<WeekEnergy, String>(
                                            dataSource: visibilityWidgetsWatch.WeekEnergyData,
                                            xValueMapper:
                                                (WeekEnergy weekEnergy, _) =>
                                            weekEnergy.time,
                                            yValueMapper:
                                                (WeekEnergy weekEnergy, _) =>
                                            weekEnergy.energy,
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                      ]),
                                ),
                              ],
                            )),
                      // second tab bar view widget
                       Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Total Consumption',style:TextStyle(fontSize: 20.sp,color: Colors.grey)),
                                Text('${visibilityWidgetsWatch.totalConsumptionMonth} kWh',style:TextStyle(fontSize: 24.sp,color: Colors.black)),
                                Text('Energy (kWh)',style:TextStyle(fontSize: 14.sp,color: Colors.grey)),
                                SizedBox(height: ScreenUtil().setHeight(10),),
                                Container(
                                  height: ScreenUtil().setHeight(350),
                                  child: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(
                                        arrangeByIndex: true,
                                        desiredIntervals: 30,
                                        majorGridLines: MajorGridLines(color:Colors.transparent,),
                                      ),
                                      primaryYAxis: NumericAxis(
                                        //title: AxisTitle(text:"Energy (kWh)",textStyle: TextStyle(fontSize: 14.sp)),
                                        labelFormat: '{value}',
                                      ),
                                      series: <
                                          ColumnSeries<MonthEnergy, int>>[
                                        ColumnSeries<MonthEnergy, int>(
                                            dataSource: visibilityWidgetsWatch
                                                .MonthEnergyData,
                                            xValueMapper:
                                                (MonthEnergy monthEnergy, _) =>
                                            monthEnergy.time,
                                            yValueMapper:
                                                (MonthEnergy monthEnergy, _) =>
                                            monthEnergy.energy,
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                      ]),
                                ),
                              ],
                            )),
                       Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('Total Consumption',style:TextStyle(fontSize: 20.sp,color: Colors.grey)),
                                Text('${visibilityWidgetsWatch.totalConsumptionYear} kWh',style:TextStyle(fontSize: 24.sp,color: Colors.black)),
                                Text('Energy (kWh)',style:TextStyle(fontSize: 14.sp,color: Colors.grey)),
                                SizedBox(height: ScreenUtil().setHeight(10),),
                                Container(
                                  height: ScreenUtil().setHeight(350),
                                  child: SfCartesianChart(
                                      primaryXAxis: CategoryAxis(
                                        arrangeByIndex: true,
                                        desiredIntervals: 12,
                                        labelStyle: TextStyle(color: Colors.grey,fontSize: 14.sp,),
                                        majorGridLines: MajorGridLines(color:Colors.transparent,),
                                      ),
                                      primaryYAxis: NumericAxis(
                                        //title: AxisTitle(text:"Energy (kWh)",textStyle: TextStyle(fontSize: 14.sp)),
                                        labelFormat: '{value}',
                                      ),
                                      series: <ColumnSeries<YearEnergy, String>>[
                                        ColumnSeries<YearEnergy, String>(
                                            dataSource: visibilityWidgetsWatch
                                                .YearEnergyData,
                                            xValueMapper:
                                                (YearEnergy yearEnergy, _) =>
                                            yearEnergy.time,
                                            yValueMapper:
                                                (YearEnergy yearEnergy, _) =>
                                            yearEnergy.energy,
                                            color: Colors.green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                      ]),
                                ),
                              ],
                            )),

                    ],
                  ),
               ),
             ),
           ),
            /* Container(
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
                        onPressed: () {
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(Navigator.defaultRouteName),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),*/
        ],
      ),
          )
          : CommonWidgets().CommonLoader(context),
    );
  }

}
class WeekEnergy {
  double energy;
  String time;

  WeekEnergy(this.energy, this.time);
}

class MonthEnergy {
  num energy;
  int time;

  MonthEnergy(this.energy, this.time);
}

class YearEnergy {
  double energy;
  String time;

  YearEnergy(this.energy, this.time);
}

