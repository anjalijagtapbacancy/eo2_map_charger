import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eo2_map_charger/model/Response/ResponseMsgId8.dart';
import 'package:eo2_map_charger/user_name.dart';
import 'package:flutter/cupertino.dart';

import 'CommonWidgets.dart';
import 'ConnectServer.dart';
import 'Connection.dart';
import 'ConstantFunction/Constants.dart';
import 'package:intl/intl.dart';
import 'ev_analysis.dart';
import 'model/Request/CommonRequest.dart';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'model/Request/RequestMsgId1.dart';
import 'model/Request/RequestMsgId10.dart';
import 'model/Request/RequestMsgId12.dart';
import 'model/Request/RequestMsgId13.dart';
import 'model/Request/RequestMsgId18.dart';
import 'model/Request/RequestMsgId2.dart';
import 'model/Request/RequestMsgId3.dart';
import 'model/Request/RequestMsgId32.dart';
import 'model/Request/RequestMsgId4.dart';
import 'model/Request/RequestMsgId9.dart';
import 'model/Response/CommonResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/Response/ResponseMsgId10.dart';
import 'model/Response/ResponseMsgId12.dart';
import 'model/Response/ResponseMsgId14.dart';
import 'model/Response/ResponseMsgId15.dart';
import 'model/Response/ResponseMsgId16.dart';
import 'model/Response/ResponseMsgId19.dart';
import 'model/Response/ResponseMsgId21.dart';
import 'model/Response/ResponseMsgId22.dart';
import 'model/Response/ResponseMsgId23.dart';
import 'model/Response/ResponseMsgId31.dart';
import 'model/Response/ResponseMsgId33.dart';
import 'model/Response/ResponseMsgId34.dart';
import 'model/Response/ResponseMsgId6.dart';

class VisibilityWidgets with ChangeNotifier {
  String qrText = "";
  String user_name = "";
  Socket socket;
  String appbar_name="Dashboard";
  bool isrunning = false, isNetwork = false;
  int status;
  int index = 0;
  List<WeekEnergy> WeekEnergyData = [];
  List<MonthEnergy> MonthEnergyData = [];
  List<YearEnergy> YearEnergyData = [];
  int selectedIndex=0;
  num hour_diff = 0.0, min_diff = 0.0;
  num charging_current = 0.0,
      charging_voltage = 0.0,
      charging_power = 0.0,
      overall_energy = 0.0;
  int TIMEDELAY = 10;
  int charging_state = 0,
      auto_mode,
      currentMax,
      startHour = 00,
      startMinute = 00,
      endHour = 00,
      endMinute = 00,
      DurationLog = 0,
      secLog = 0,
      hourLog = 0,
      minuteLog = 0,
      energyLog = 0,
      TotalOccurrences = 0,
      Occurrences = 0,
      StartNumber = -4,
      EndNumber = 1,
      logNumber = 0;

  int StartTime = 0,
      diffHour = 0,
      diffMinute = 0,
      diffSeconds = 0,
      DifferenceTime;

  DateTime date, StartDate;
  String timeLog = "",
      modLog = "",
      device_id = "",
      modeValue,
      fileName,
      fileUrl,
      firmwareVersion="Not available";
  bool isScheduling = false, CurrentLog = true, isPaused = false;
  List<Array10> ChargerSummaryList = new List();
  Array10 array10 = new Array10();
  List<Array12> WeekEnergyList;

  List<Array12> MonthEnergyList;

  List<Array12> YearEnergyList;
  num energy,totalConsumptionWeek=0,totalConsumptionMonth=0,totalConsumptionYear=0;
  bool readyLoader = true,
      stopLoader = true,
      ChargingSummaryLoader = false,
      EvAnalysisLoader = false,
      isResponse8 = false;
  List<Array33> rfidList=[];
  bool rfidShowLoader = false;
  StreamSubscription subscription;
  Timer HeartBeatTimer;
  //bool HeartBeat;
  CommonResponse commonResponse = new CommonResponse();
  ResponseMsgId6 responseMsgId6 = new ResponseMsgId6();
  Properties6 responsePropertyMsgId6 = new Properties6();
  ResponseMsgId8 responseMsgId8;
  Properties8 responsePropertyMsgId8 = new Properties8();
  Properties1 commonResponseProperty = new Properties1();
  ResponseMsgId10 responseMsgId10 = new ResponseMsgId10();
  Properties10 responsePropertyMsgId10 = new Properties10();
  ResponseMsgId12 responseMsgId12 = new ResponseMsgId12();
  Properties12 responsePropertyMsgId12 = new Properties12();
  ResponseMsgId14 responseMsgId14 = new ResponseMsgId14();
  Properties14 responsePropertyMsgId14 = new Properties14();
  ResponseMsgId15 responseMsgId15 = new ResponseMsgId15();
  Properties15 responsePropertyMsgId15 = new Properties15();
  ResponseMsgId16 responseMsgId16 = new ResponseMsgId16();
  Properties16 responsePropertyMsgId16 = new Properties16();
  ResponseMsgId19 responseMsgId19 = new ResponseMsgId19();
  Properties19 responsePropertyMsgId19 = new Properties19();
  ResponseMsgId21 responseMsgId21 = new ResponseMsgId21();
  Properties21 responsePropertyMsgId21 = new Properties21();
  ResponseMsgId22 responseMsgId22 = new ResponseMsgId22();
  Properties22 responsePropertyMsgId22 = new Properties22();
  ResponseMsgId23 responseMsgId23 = new ResponseMsgId23();
  Properties23 responsePropertyMsgId23 = new Properties23();
  ResponseMsgId31 responseMsgId31 = new ResponseMsgId31();
  Properties31 responsePropertyMsgId31 = new Properties31();
  ResponseMsgId33 responseMsgId33 = new ResponseMsgId33();
  Properties33 responsePropertyMsgId33 = new Properties33();
  ResponseMsgId34 responseMsgId34 = new ResponseMsgId34();
  Properties34 responsePropertyMsgId34 = new Properties34();

  ClearLists() {
    WeekEnergyList = null;
    MonthEnergyList = null;
    YearEnergyList = null;
    WeekEnergyData.clear();
    MonthEnergyData.clear();
    YearEnergyData.clear();
  }

  setappbar_name(String name) {
    appbar_name = name;
    notifyListeners();
  }

  setsocket(Socket Socket) {
    socket = Socket;
    notifyListeners();
  }

  setSelectedIndex(int selected_index) {
    selectedIndex = selected_index;
    notifyListeners();
  }

  void setQr(String scanData) {
    qrText = scanData;
    notifyListeners();
  }
  void setuser_name(String name) {
    user_name = name;
    notifyListeners();
  }
  void setIndex(int Index) {
    index = Index;
    notifyListeners();
  }

  bool setRunning(bool running) {
    isrunning = running;
    notifyListeners();
  }

  bool setRfidShowLoader(bool value){
    rfidShowLoader = value;
    notifyListeners();
  }

  Future<void> UserName() async {
    final pref = await SharedPreferences.getInstance();
    setuser_name((pref.getString('user_name') != null) ? pref.getString('user_name') : "");
  }

  Future<void> MacAddress() async {
   final pref = await SharedPreferences.getInstance();
   setQr((pref.getString('qrtxt') != null) ? pref.getString('qrtxt') : "");
  }
  Future<void> Network(BuildContext context) async {
    ConnectivityResult connectivityResult;
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi) {
      if (socket == null) {
        responseMsgId8 = null;
        print("close if");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Connection()),
            (Route<dynamic> route) => false);
      }
    } else {
      responseMsgId8 = null;
      print("close else");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Connection()),
          (Route<dynamic> route) => false);
    }
    notifyListeners();
  }


  Future<void> setResponse(
      BuildContext context, String response, String msgId) async {
    switch (msgId) {
      case "1":
        try {
          stopLoader = false;
          commonResponse = CommonResponse.fromJson(jsonDecode(response));
          commonResponseProperty = commonResponse.properties;
          status = commonResponseProperty.status;
          print(status.toString() + msgId.toString());
          if (status != 0) {
            CommonWidgets().showErrorSnackbar(context, status);
          } /*else {
            CommonRequests(20);
          }*/
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "3":
      case "4":
        try {
          stopLoader = false;
          commonResponse = CommonResponse.fromJson(jsonDecode(response));
          commonResponseProperty = commonResponse.properties;
          status = commonResponseProperty.status;
          print(status.toString() + msgId.toString());
          if (status != 0) {
            CommonWidgets().showErrorSnackbar(context, status);
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "2":
        try {
          commonResponse = CommonResponse.fromJson(jsonDecode(response));
          commonResponseProperty = commonResponse.properties;
          status = commonResponseProperty.status;
          print(status.toString() + msgId.toString());
          if (status < 1) {
            final pref = await SharedPreferences.getInstance();
            pref.setInt("startHour", startHour);
            pref.setInt("startMinute", startMinute);
            pref.setInt("endHour", endHour);
            pref.setInt("endMinute", endMinute);
            pref.setBool("isScheduling", isScheduling);
            CommonRequests(15);
          } else {
            CommonWidgets().showErrorSnackbar(context, status);
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "6":
        try {
          responseMsgId6 = ResponseMsgId6.fromJson(jsonDecode(response));
          responsePropertyMsgId6 = responseMsgId6.properties;
          status = responsePropertyMsgId6.status;
          if (isResponse8 == false) CommonRequests(20);
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            charging_current = responsePropertyMsgId6.current;
            charging_voltage = responsePropertyMsgId6.voltage;
            charging_power = responsePropertyMsgId6.power;
            overall_energy = responsePropertyMsgId6.sessionEnergy;
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "8":
        try {
          readyLoader = false;
          isResponse8 = true;
          responseMsgId8 = new ResponseMsgId8();
          responseMsgId8 = ResponseMsgId8.fromJson(jsonDecode(response));
          responsePropertyMsgId8 = responseMsgId8.properties;
          status = responseMsgId8.properties.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            if (!isPaused)
              //charging_state = 66;
              charging_state = responsePropertyMsgId8.evChargingState;
            else {
              if (responsePropertyMsgId8.evChargingState == 66 || responsePropertyMsgId8.evChargingState == 65) {
                //charging_state = 66;
              }
              else{
                charging_state = responsePropertyMsgId8.evChargingState;
                setIsPaused(false);
              }
            }
            if (charging_state == 67) {
              startCounting();
            }
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "10":
        try {
          setChargingSummaryLoader(false);
          responseMsgId10 = ResponseMsgId10.fromJson(jsonDecode(response));
          responsePropertyMsgId10 = responseMsgId10.properties;
          status = responsePropertyMsgId10.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            ChargerSummaryList = responsePropertyMsgId10.array;
            if (CurrentLog || isPaused) {
              final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm:ss aa');
              timeLog = formatter.format(DateTime.fromMillisecondsSinceEpoch(
                  (ChargerSummaryList[0].time) * 1000));
              if (ChargerSummaryList[0].mode == 1 ||
                  ChargerSummaryList[0].mode == 6)
                modLog = "Manual";
              else if (ChargerSummaryList[0].mode == 2 ||
                  ChargerSummaryList[0].mode == 7)
                modLog = "Schedule";
              else
                modLog = "-Manual";
              DurationLog = ChargerSummaryList[0].duration;
              secLog = DurationLog % 60;
              minuteLog = ((DurationLog / 60) % 60).round();
              hourLog = ((DurationLog / 60) / 60).round();
              energyLog = ChargerSummaryList[0].sessionEnergy;
            }
          }
        } catch (e) {
          CommonWidgets().showToast("Something Wrong In Summary");
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "12":
        try {
          responseMsgId12 = ResponseMsgId12.fromJson(jsonDecode(response));
          responsePropertyMsgId12 = responseMsgId12.properties;
          status = responsePropertyMsgId12.status;
          int type = responsePropertyMsgId12.type;
          if (status != null) {
            setEvAnalysisLoader(false);
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            if (type == 1) {
              setEvAnalysisLoader(false);
              setWeekEnergyData(null);
              WeekEnergyData=[];
              WeekEnergyList = new List();
              WeekEnergyList = responsePropertyMsgId12.array;
              getWeekData();
            } else if (type == 2) {
              setEvAnalysisLoader(false);
              setMonthEnergyData(null);
              MonthEnergyData=[];
              MonthEnergyList = new List();
              MonthEnergyList = responsePropertyMsgId12.array;
              getMonthData();
            } else if (type == 3) {
              setEvAnalysisLoader(false);
              setYearEnergyData(null);
              YearEnergyData=[];
              YearEnergyList = new List();
              YearEnergyList = responsePropertyMsgId12.array;
              getYearData();
            }
          }
        } catch (e) {
          setEvAnalysisLoader(false);
          CommonWidgets().showToast("Something Wrong In Graph data");
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "13":
        try {
          commonResponse = CommonResponse.fromJson(jsonDecode(response));
          commonResponseProperty = commonResponse.properties;
          status = commonResponseProperty.status;
          print(status.toString() + msgId.toString());
          if (status < 1) {
            final pref = await SharedPreferences.getInstance();
            pref.setInt("currentMax", currentMax);
            CommonRequests(14);
          } else {
            CommonWidgets().showErrorSnackbar(context, status);
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "14":
        try {
          // isResponse14 = true;
          responseMsgId14 = ResponseMsgId14.fromJson(jsonDecode(response));
          responsePropertyMsgId14 = responseMsgId14.properties;
          status = responsePropertyMsgId14.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            if (responsePropertyMsgId14.maxCurrent == 6)
              currentMax = 0;
            else if (responsePropertyMsgId14.maxCurrent == 10)
              currentMax = 1;
            else if (responsePropertyMsgId14.maxCurrent == 15)
              currentMax = 2;
            else if (responsePropertyMsgId14.maxCurrent == 18)
              currentMax = 3;
            else if (responsePropertyMsgId14.maxCurrent == 24)
              currentMax = 4;
            else if (responsePropertyMsgId14.maxCurrent == 30)
              currentMax = 5;
            else
              currentMax = 5;
            /*currentMax = String.valueOf(responsePropertyMsgId14.getMaxCurrent());
            PreferenceMan.getInstance().setMaxCurrent(Integer.parseInt(currentMax));
          */
            final pref = await SharedPreferences.getInstance();
            pref.setInt("currentMax", currentMax);
          }
          //  statusMsg(status, AppController.getInstance(), msgId);
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "15":
        try {
          //isResponse15 = true;
          responseMsgId15 = ResponseMsgId15.fromJson(jsonDecode(response));
          responsePropertyMsgId15 = responseMsgId15.properties;
          int status = responsePropertyMsgId15.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            startHour = (responsePropertyMsgId15.wdStartTm / 100).floor();
            startMinute = responsePropertyMsgId15.wdStartTm % 100;
            endHour = (responsePropertyMsgId15.wdEndTm / 100).floor();
            endMinute = responsePropertyMsgId15.wdEndTm % 100;
            isScheduling = responsePropertyMsgId15.isSchedule != 0;

            final pref = await SharedPreferences.getInstance();
            pref.setInt("startHour", startHour);
            pref.setInt("startMinute", startMinute);
            pref.setInt("endHour", endHour);
            pref.setInt("endMinute", endMinute);
            pref.setBool("isScheduling", isScheduling);
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "16":
        try {
          responseMsgId16 = ResponseMsgId16.fromJson(jsonDecode(response));
          responsePropertyMsgId16 = responseMsgId16.properties;
          int status = responsePropertyMsgId16.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            setLogNumber(responsePropertyMsgId16.log);
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "18":
        try {
          commonResponse = CommonResponse.fromJson(jsonDecode(response));
          commonResponseProperty = commonResponse.properties;
          status = commonResponseProperty.status;
          CommonRequests(19);
          if (status != 0) {

            CommonWidgets().showErrorSnackbar(context, status);
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "19":
        try {
          responseMsgId19 = ResponseMsgId19.fromJson(jsonDecode(response));
          responsePropertyMsgId19 = responseMsgId19.properties;
          status = responsePropertyMsgId19.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            auto_mode = responsePropertyMsgId19.automode;
            if (auto_mode == 0) {
              modeValue = "Normal Mode";
            } else if (auto_mode == 1) {
              modeValue = "Plug and Play Mode";
            } else if (auto_mode == 2) {
              modeValue = "RFID Mode";
            } else if (auto_mode == 3) {
              modeValue = "OCPP Mode";
            } else if (auto_mode == 4) {
              modeValue = "Plug and Play Mode \nWith Push Button";
            }
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "21":
        try {
          //isResponse21 = true;
          responseMsgId21 = ResponseMsgId21.fromJson(jsonDecode(response));
          responsePropertyMsgId21 = responseMsgId21.properties;
          status = responsePropertyMsgId21.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            device_id = responsePropertyMsgId21.devId;
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "22":
        try {
          responseMsgId22 = ResponseMsgId22.fromJson(jsonDecode(response));
          responsePropertyMsgId22 = responseMsgId22.properties;
          status = responsePropertyMsgId22.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            setStartTime(responsePropertyMsgId22.starttm);
            //setStartTime(1640681762);
            StartDate = DateTime.fromMillisecondsSinceEpoch(
                (StartTime * 1000).ceil() as int);
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "23":
        try {
          responseMsgId23 = ResponseMsgId23.fromJson(jsonDecode(response));
          responsePropertyMsgId23 = responseMsgId23.properties;
          status = responsePropertyMsgId23.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            firmwareVersion=responsePropertyMsgId23.fwVersion;
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "31":
        try {
          responseMsgId31 = ResponseMsgId31.fromJson(jsonDecode(response));
          //responsePropertyMsgId31 = responseMsgId31.properties;
          //HeartBeat=true;
          print('true');
          if(HeartBeatTimer !=null)
            HeartBeatTimer.cancel();
          responseMsgId31=null;
          print('null');
          HeartBeatTimer=Timer( const Duration(seconds: 5),
                () {
              print('after 5 sec');
              if(responseMsgId31==null){
                print('socket close');
                if (socket != null)
                  socket.destroy();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Connection()),
                        (Route<dynamic> route) => false);
                HeartBeatTimer.cancel();
              }
            },
          );
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "33":
        try {
          responseMsgId33 = ResponseMsgId33.fromJson(jsonDecode(response));
          responsePropertyMsgId33 = responseMsgId33.properties;
          status = responsePropertyMsgId33.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            rfidList = responsePropertyMsgId33.array;
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "34":
        try {
          responseMsgId34 = ResponseMsgId34.fromJson(jsonDecode(response));
          responsePropertyMsgId34 = responseMsgId34.properties;
          status = responsePropertyMsgId34.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            setRfidShowLoader(false);
            if(responsePropertyMsgId34.errorcode == 1)
              CommonWidgets().showToast('SuccessFully Added');
            else if(responsePropertyMsgId34.errorcode == 2)
              CommonWidgets().showToast('Already Added');
            else if(responsePropertyMsgId34.errorcode == 3)
              CommonWidgets().showToast('Timeout');
            else if(responsePropertyMsgId34.errorcode == 4)
              CommonWidgets().showToast('Full');
            CommonRequests(33);
            Navigator.pop(context);
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "255":
        try {
          commonResponse = CommonResponse.fromJson(jsonDecode(response));
          commonResponseProperty = commonResponse.properties;
          status = commonResponseProperty.status;
          CommonWidgets().showErrorSnackbar(context, status);
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
    }
  }

  Future<void> CommonRequests(int msgId) async {
    try {
      CommonRequest commonRequest = CommonRequest.setData(msgId);
      await sendMessage(socket, jsonEncode(commonRequest));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  Future<void> SendRequest1(int msgId, int time) async {
    try {
      RequestMsgId1 requestMsgId1 = RequestMsgId1.setData(msgId, time);
      await sendMessage(socket, jsonEncode(requestMsgId1));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  Future<void> SendRequest2(int msgId, bool Scheduling, int wdStartTime,
      int wdEndTime, int weStartTime, int weEndTime, int maxCurrent) async {
    try {
      RequestMsgId2 requestMsgId2 = RequestMsgId2.setData(msgId, Scheduling,
          wdStartTime, wdEndTime, weStartTime, weEndTime, maxCurrent);
      await sendMessage(socket, jsonEncode(requestMsgId2));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  Future<void> SendRequest3(int msgId, int chargingStartStop) async {
    try {
      RequestMsgId3 requestMsgId3 =
          RequestMsgId3.setData(msgId, chargingStartStop);
      await sendMessage(socket, jsonEncode(requestMsgId3));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  Future<void> SendRequest4(int msgId, String url, String fileName) async {
    try {
      RequestMsgId4 requestMsgId4 = RequestMsgId4.setData(msgId, url, fileName);
      await sendMessage(socket, jsonEncode(requestMsgId4));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  Future<void> SendRequest9(int msgId, int resetEnergy) async {
    try {
      RequestMsgId9 requestMsgId9 = RequestMsgId9.setData(msgId, resetEnergy);
      await sendMessage(socket, jsonEncode(requestMsgId9));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  Future<void> SendRequest10(int msgId, int startNumber, int endNumber) async {
    try {
      RequestMsgId10 requestMsgId10 =
          RequestMsgId10.setData(msgId, startNumber, endNumber);
      await sendMessage(socket, jsonEncode(requestMsgId10));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  Future<void> SendRequest12(int msgId, int type) async {
    try {
      RequestMsgId12 requestMsgId12 = RequestMsgId12.setData(msgId, type);
      await sendMessage(socket, jsonEncode(requestMsgId12));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  Future<void> SendRequest13(int msgId, int maxCurrent) async {
    try {
      RequestMsgId13 requestMsgId13 = RequestMsgId13.setData(msgId, maxCurrent);
      await sendMessage(socket, jsonEncode(requestMsgId13));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  Future<void> SendRequest18(int msgId, int automode) async {
    try {
      RequestMsgId18 requestMsgId18 = RequestMsgId18.setData(msgId, automode);
      await sendMessage(socket, jsonEncode(requestMsgId18));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  Future<void> SendRequest32(int msgId, int action) async {
    try {
      RequestMsgId32 requestMsgId32 = RequestMsgId32.setData(msgId, action);
      await sendMessage(socket, jsonEncode(requestMsgId32));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  bool isSetting_OTA(){
    if (auto_mode == 0) {
      if (charging_state == 67) {
        return false;
      }else{
        return true;
      }
    }else{
      return true;
    }
    notifyListeners();
  }
  String Tips() {
    if (auto_mode == 0) {
      if (charging_state == 65) {
        return "Tips: Please insert the Charging Gun";
      } else if (charging_state == 66) {
        return "";
      } else if (charging_state == 67) {
        return "";
      } else if (charging_state == 70) {
        return "";
      } else if (charging_state == 73) {
        return "Tips: There is Some Fault";
      }
    } else if(auto_mode == 1) {
      return "Tips: Your Charger is in Plug and Play Mode";
    } else if(auto_mode == 2) {
      return "Tips: Your Charger is in RFID Mode";
    } else if(auto_mode == 3) {
      return "Tips: Your Charger is in OCPP Mode";
    } else if(auto_mode == 4) {
      return "Tips: Your Charger is in Plug and Play Mode With Push Button";
    }
    notifyListeners();
  }

  bool isTip() {
    if (auto_mode == 0) {
      if (charging_state == 65) {
        return true;
      } else if (charging_state == 66) {
        return false;
      } else if (charging_state == 67) {
        return false;
      } else if (charging_state == 70) {
        return true;
      } else if (charging_state == 73) {
        return true;
      }
    } else {
      return true;
    }
    notifyListeners();
  }

  bool isbtnScheduling() {
    if (auto_mode == 0) {
      if (charging_state == 65) {
        return true;
      } else if (charging_state == 66) {
        return true;
      } else if (charging_state == 67) {
        return false;
      } else if (charging_state == 70) {
        return false;
      } else if (charging_state == 73) {
        return true;
      }
    } else {
      return true;
    }
    notifyListeners();
  }

  bool isSizedBox() {
    if (auto_mode == 0) {
      if (charging_state == 65) {
        return true;
      } else if (charging_state == 66) {
        return false;
      } else if (charging_state == 67) {
        return true;
      } else if (charging_state == 70) {
        return true;
      } else if (charging_state == 73) {
        return true;
      }
    } else {
      return true;
    }
    notifyListeners();
  }

  bool isbtnReady() {
    if (auto_mode == 0) {
      if (charging_state == 65) {
        return false;
      } else if (charging_state == 66) {
        return true;
      } else if (charging_state == 67) {
        return false;
      } else if (charging_state == 70) {
        return false;
      } else if (charging_state == 73) {
        return false;
      }
    } else {
      return false;
    }
    notifyListeners();
  }

  bool isbtnBoost() {
    if (auto_mode == 0) {
      if (charging_state == 65) {
        return true;
      } else if (charging_state == 66) {
        return true;
      } else if (charging_state == 67) {
        return false;
      } else if (charging_state == 70) {
        return false;
      } else if (charging_state == 73) {
        return true;
      }
    } else {
      return true;
    }
    notifyListeners();
  }

  bool isChargingTxt() {
    if (auto_mode == 0) {
      if (charging_state == 65) {
        return false;
      } else if (charging_state == 66) {
        return true;
      } else if (charging_state == 67) {
        return false;
      } else if (charging_state == 70) {
        return false;
      } else if (charging_state == 73) {
        return false;
      }
    } else {
      return false;
    }
    notifyListeners();
  }

  bool isNextChargingTxt() {
    if (auto_mode == 0) {
      if (charging_state == 65) {
        return false;
      } else if (charging_state == 66) {
        return true;
      } else if (charging_state == 67) {
        return false;
      } else if (charging_state == 70) {
        return false;
      } else if (charging_state == 73) {
        return false;
      }
    } else {
      return false;
    }
    notifyListeners();
  }

  bool isReadyCard() {
    if (auto_mode == 0) {
      if (charging_state == 65) {
        return true;
      } else if (charging_state == 66) {
        return true;
      } else if (charging_state == 67) {
        return false;
      } else if (charging_state == 70) {
        return false;
      } else if (charging_state == 73) {
        return true;
      }
    } else {
      return true;
    }
    notifyListeners();
  }

  bool isChargingCard() {
    if (auto_mode == 0) {
      if (charging_state == 65) {
        return false;
      } else if (charging_state == 66) {
        return false;
      } else if (charging_state == 67) {
        return true;
      } else if (charging_state == 70) {
        return false;
      } else if (charging_state == 73) {
        return false;
      }
    } else {
      return false;
    }
    notifyListeners();
  }

  bool isPausedCard() {
    if (auto_mode == 0) {
      if (charging_state == 65) {
        return false;
      } else if (charging_state == 66) {
        return false;
      } else if (charging_state == 67) {
        return false;
      } else if (charging_state == 70) {
        return true;
      } else if (charging_state == 73) {
        return false;
      }
    } else {
      return false;
    }
    notifyListeners();
  }

  bool isTextprev() {
    if (CurrentLog == false) {
      if (StartNumber <= 1 || Occurrences == TotalOccurrences) {
        return false;
      } else {
        return true;
      }
    }
    //notifyListeners();
  }

  bool isTextNext() {
    if (CurrentLog == false) {
      if (EndNumber >= logNumber || Occurrences < 0)
        return false;
      else
        return true;
    }
    // notifyListeners();
  }

  void setCurrentLog(bool current_log) {
    CurrentLog = current_log;
    notifyListeners();
  }

  void setisResponse8(bool IsResponse8) {
    isResponse8 = IsResponse8;
    notifyListeners();
  }

  void setisScheduling(bool is_Scheduling) {
    isScheduling = is_Scheduling;
    notifyListeners();
  }

  void setStartHour(int hour) {
    startHour = hour;
    notifyListeners();
  }

  void setStartMinute(int minute) {
    startMinute = minute;
    notifyListeners();
  }

  void setEndHour(int hour) {
    endHour = hour;
    notifyListeners();
  }

  void setEndMinute(int minute) {
    endMinute = minute;
    notifyListeners();
  }

  void setReadyLoader(bool ready_Loader) {
    readyLoader = ready_Loader;
    notifyListeners();
  }

  void setCurrentMax(int current) {
    currentMax = current;
    notifyListeners();
  }

  void setEvAnalysisLoader(bool evLoader) {
    EvAnalysisLoader = evLoader;
    notifyListeners();
  }

  void setStopLoader(bool stop_loader) {
    stopLoader = stop_loader;
    notifyListeners();
  }

  void setIsPaused(bool paused) {
    isPaused = paused;
    notifyListeners();
  }

  void setChargingState(int chargingState) {
    charging_state = chargingState;
    notifyListeners();
  }

  void setChargingSummaryLoader(bool chargingSummaryLoader) {
    ChargingSummaryLoader = chargingSummaryLoader;
    notifyListeners();
  }

  void setStartNumber(int start_number) {
    StartNumber = start_number;
    notifyListeners();
  }

  void setEndNumber(int end_number) {
    EndNumber = end_number;
    notifyListeners();
  }
  void setLogNumber(int log_number) {
    logNumber = log_number;
    notifyListeners();
  }

  void setTotalOccurrences(int total_occurence) {
    TotalOccurrences = total_occurence;
    notifyListeners();
  }

  void setOccurrences(int occurrences) {
    Occurrences = occurrences;
    notifyListeners();
  }

  void setChargerSummaryList(List<Array10> List) {
    ChargerSummaryList = List;
    notifyListeners();
  }

  void setmodeValue(String mode_value) {
    modeValue = mode_value;
    notifyListeners();
  }

  void setAutoMode(int mode) {
    auto_mode = mode;
    notifyListeners();
  }

  void setWeekEnergyData(WeekEnergy weekEnergy) {
    WeekEnergyData.add(weekEnergy);
  }

  void setMonthEnergyData(MonthEnergy monthEnergy) {
    MonthEnergyData.add(monthEnergy);
  }

  void setYearEnergyData(YearEnergy yearEnergy) {
    YearEnergyData.add(yearEnergy);
  }

  void setStartTime(int startTime) {
    StartTime = startTime;
    notifyListeners();
  }

  void setfileName(String file_name) {
    fileName = file_name;
    notifyListeners();
  }

  void setfileUrl(String file_url) {
    fileUrl = file_url;
    notifyListeners();
  }

  void setTIMEDELAY(int TIME_DELAY) {
    TIMEDELAY = TIME_DELAY;
    notifyListeners();
  }

  num timeDiffernce() {
    num diffHour, diffMinute = 0.0;
    num end_hour = endHour;
    num end_minute = endMinute;
    num start_hour = startHour;
    num start_minute = startMinute;
    if (end_minute < start_minute) {
      if (end_hour <= start_hour) {
        end_hour += 24;
      }
      end_minute += 60;
      end_hour--;
    } else {
      if (end_hour < start_hour) {
        end_hour += 24;
      }
    }
    diffHour = end_hour - start_hour;
    diffMinute = end_minute - start_minute;
    if (diffMinute > 60) {
      diffMinute = diffMinute - 60;
    }
    hour_diff = diffHour;
    min_diff = diffMinute;
    num diffTime = (((diffHour * 60) + diffMinute)).roundToDouble();
    return diffTime;
  }

  void getWeekData() {
    try {
      if (WeekEnergyList != null) {
        final DateFormat formatter = DateFormat('EEE');
        String dayOfTheWeek = formatter.format(new DateTime.now());
        int StartDayIndex = findIndex(Constants.WeekDays, dayOfTheWeek);
        // int Index = StartDayIndex;
        WeekEnergyList = List.from(WeekEnergyList.reversed);
        int energyIndex = 0;
        for (int j = StartDayIndex; j <= 6; j++) {
           energy = WeekEnergyList[energyIndex].energy.toDouble();
          setWeekEnergyData(WeekEnergy(
              (energy / 1000).floorToDouble(), Constants.WeekDays[j]));

          energyIndex++;
        }

        for (int i = 0; i < StartDayIndex; i++) {
           energy = WeekEnergyList[energyIndex].energy.toDouble();
          setWeekEnergyData(WeekEnergy(
              (energy / 1000).floorToDouble(), Constants.WeekDays[i]));
          //WeekEnergyData.add();
          energyIndex++;
        }

        for(int i=0;i<WeekEnergyData.length;i++){
          totalConsumptionWeek=totalConsumptionWeek+WeekEnergyData[i].energy;
        }
        notifyListeners();
      }
    } catch (e) {
      print("===ExceptionWeek: " + e.toString());
    }
  }

  void getMonthData() {
     try {
    if (MonthEnergyList != null) {
      MonthEnergyList = List.from(MonthEnergyList.reversed);
      int PrePrevMonthDifference = 0,
          PrePreMonthIndex = 0,
          PrevMonthIndex = 0,
          StartMonthIndex = 0,
          // StartDayIndex,
          PrevPreDifference = 0,
          PreDifference = 0,
          PrevMonthDifference = 0,
          PreEndPoint = 0,
          PrePreEndPoint = 0;
      final DateFormat formatter1 = DateFormat('dd');
      final DateFormat formatter2 = DateFormat('MMM');
      final DateFormat formatter3 = DateFormat('yyyy');
      var date_ = formatter1.format(new DateTime.now());
      String month = formatter2.format(new DateTime.now());
      var year_ = formatter3.format(new DateTime.now());
      int year = int.parse(year_);
      int date = int.parse(date_);
      print("$date:$month:$year");
      //  StartDayIndex = findIndex(Constants.Dates, date);
      StartMonthIndex = findIndex(Constants.Months, month);
      PreDifference = 31 - date;

      PrevMonthIndex = StartMonthIndex - 1;
      if(PrevMonthIndex==-1){
        PrevMonthIndex=11;
      }
      String PrevMonth = Constants.Months[PrevMonthIndex];
      if (PrevMonth == "Jan" ||
          PrevMonth == "Mar" ||
          PrevMonth == "May" ||
          PrevMonth == "Jul" ||
          PrevMonth == "Aug" ||
          PrevMonth == "Oct" ||
          PrevMonth == "Dec") {
        PreEndPoint = 31;
      } else if (PrevMonth == "Feb") {
        if (year % 4 == 0) {
          PreEndPoint = 29;
        } else {
          PreEndPoint = 28;
        }
      } else {
        PreEndPoint = 30;
      }
      PrevMonthDifference = PreEndPoint - PreDifference + 1;
      int energyIndex = 0;
      if (PrevMonthDifference > 0) {
        for (int i = PrevMonthDifference; i <= PreEndPoint; i++) {
           energy = MonthEnergyList[energyIndex].energy.toDouble();
          setMonthEnergyData(MonthEnergy((energy / 1000).floorToDouble(), i));
          //MonthEnergyData.add();
          energyIndex++;
        }
      } else {
        if (date_ == "2" && month == "Mar" && year % 4 == 0)
          PrevPreDifference = 29 - PreEndPoint;
        else
          PrevPreDifference = 30 - PreEndPoint;
        PrePreMonthIndex = PrevMonthIndex - 1;
        if(PrePreMonthIndex==-1){
          PrePreMonthIndex=11;
        }
        String PrePrevMonth = Constants.Months[PrePreMonthIndex];
        if (PrePrevMonth == "Jan" ||
            PrePrevMonth == "Mar" ||
            PrePrevMonth == "May" ||
            PrePrevMonth == "Jul" ||
            PrePrevMonth == "Aug" ||
            PrePrevMonth == "Oct" ||
            PrePrevMonth == "Dec") {
          PrePreEndPoint = 31;
        } else if (PrePrevMonth == "Feb") {
          if (year % 4 == 0) {
            PrePreEndPoint = 29;
          } else {
            PrePreEndPoint = 28;
          }
        } else {
          PrePreEndPoint = 30;
        }
        PrePrevMonthDifference = PrePreEndPoint - PrevPreDifference + 1;
        for (int i = PrePrevMonthDifference; i <= PrePreEndPoint; i++) {
          energy = MonthEnergyList[energyIndex].energy.toDouble();
          setMonthEnergyData(MonthEnergy((energy / 1000).floorToDouble(), i));
          //MonthEnergyData.add();
          energyIndex++;
        }
        for (int i = 1; i <= PreEndPoint; i++) {
          energy = MonthEnergyList[energyIndex].energy.toDouble();
          setMonthEnergyData(MonthEnergy((energy / 1000).floorToDouble(), i));
          //MonthEnergyData.add(MonthEnergy((energy / 1000).floorToDouble(), i));
          energyIndex++;
        }
      }

      for (int i = 1; i < date; i++) {
        energy = MonthEnergyList[energyIndex].energy.toDouble();
        setMonthEnergyData(MonthEnergy((energy / 1000).floorToDouble(), i));
        //MonthEnergyData.add(MonthEnergy((energy / 1000).floorToDouble(), i));
        energyIndex++;
      }
    }
    for(int i=0;i<MonthEnergyData.length;i++){
      totalConsumptionMonth=totalConsumptionMonth+MonthEnergyData[i].energy;
    }
    notifyListeners();
    } catch (e) {
      print("===ExceptionMonth: " + e.toString());
    }
  }

  void getYearData() {
    try {
      if (YearEnergyList != null) {
        int StartMonthIndex;
        final DateFormat formatter = DateFormat('MMM');
        String month = formatter.format(new DateTime.now());
        StartMonthIndex = findIndex(Constants.Months, month);
        int energyIndex = 0;
        for (int j = StartMonthIndex; j <= 11; j++) {
          energy = YearEnergyList[energyIndex].energy.toDouble();
          setYearEnergyData(
              YearEnergy((energy / 1000).floorToDouble(), Constants.Months[j]));
          // YearEnergyData.add(YearEnergy((energy / 1000).floorToDouble(), j + 1));
          energyIndex++;
        }

        for (int i = 0; i < StartMonthIndex; i++) {
          energy = YearEnergyList[energyIndex].energy.toDouble();
          setYearEnergyData(
              YearEnergy((energy / 1000).floorToDouble(), Constants.Months[i]));
          //YearEnergyData.add(YearEnergy((energy / 1000).floorToDouble(), i + 1));
          energyIndex++;
        }
        for(int i=0;i<YearEnergyData.length;i++){
          totalConsumptionYear=totalConsumptionYear+YearEnergyData[i].energy;
        }
        notifyListeners();
      }
    } catch (e) {
      print("===ExceptionYear: " + e.toString());
    }
  }

  int findIndex(List<String> list, String t) {
    if (list == null) {
      return -1;
    }
    int len = list.length;
    int i = 0;

    // traverse in the array
    while (i < len) {
      if (list[i] == t) {
        return i;
      } else {
        i = i + 1;
      }
    }
    return -1;
  }

  void startCounting() async {
    while (charging_state == 67) {
      if (StartTime != 0) {
        DifferenceTime = DateTime.now().difference(StartDate).inSeconds;
        diffSeconds = (DifferenceTime % 60);
        diffMinute = ((DifferenceTime / 60) % 60).floor();
        diffHour = ((DifferenceTime / 60) / 60).floor();
      }
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 200));
      // } else {
      //   DifferenceTime = 0;
      // }
    }
  }

  void clearData() {
    charging_current = 0;
    charging_voltage = 0;
    charging_power = 0;
    overall_energy = 0;
    notifyListeners();
  }
}
