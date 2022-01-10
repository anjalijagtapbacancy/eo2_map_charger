import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'CommonWidgets.dart';
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
    if(mounted && visibilityWidgetsWatch.responseMsgId8 != null)
      visibilityWidgetsWatch.Network(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ev Analysis"),
        backgroundColor: Colors.green,
      ),
      body: visibilityWidgetsWatch.EvAnalysisLoader == false
          ? Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // give the tab bar a height [can change hheight to preferred height]
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: Colors.green,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(
                          text: 'Last Week',
                        ),
                        Tab(
                          text: 'Last 30 Days',
                        ),
                        Tab(
                          text: 'Last Year',
                        ),
                      ],
                    ),
                  ),
                  // tab bar view here
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // first tab bar view widget
                        SingleChildScrollView(
                          child: Center(
                              child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(
                                    arrangeByIndex: true,
                                    desiredIntervals: 7,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    name: "Energy",
                                    labelFormat: '{value} kWh',
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
                                  ])),
                        ),

                        // second tab bar view widget
                        SingleChildScrollView(
                          child: Center(
                              child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(
                                    arrangeByIndex: true,
                                    desiredIntervals: 30,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    name: "Energy",
                                    labelFormat: '{value} kWh',
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
                                  ])),
                        ),
                        SingleChildScrollView(
                          child: Center(
                              child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(
                                    arrangeByIndex: true,
                                    desiredIntervals: 12,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    name: "Energy",
                                    labelFormat: '{value} kWh',
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
                                  ])),
                        ),
                      ],
                    ),
                  ),
                ],
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

