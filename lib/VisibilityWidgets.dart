import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eo2_map_charger/model/Response/ResponseMsgId35.dart';
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
import 'model/Request/RequestMsgId24.dart';
import 'model/Request/RequestMsgId26.dart';
import 'model/Request/RequestMsgId28.dart';
import 'model/Request/RequestMsgId3.dart';
import 'model/Request/RequestMsgId32.dart';
import 'model/Request/RequestMsgId35.dart';
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
import 'model/Response/ResponseMsgId25.dart';
import 'model/Response/ResponseMsgId27.dart';
import 'model/Response/ResponseMsgId31.dart';
import 'model/Response/ResponseMsgId33.dart';
import 'model/Response/ResponseMsgId34.dart';
import 'model/Response/ResponseMsgId6.dart';
import 'model/Response/ResponseMsgId6_single.dart';

class VisibilityWidgets with ChangeNotifier {
  String qrText = "";
  String user_name = "";
  Socket socket;
  String appbar_name="Dashboard";
  bool isrunning = false, isNetwork = false;
  int status;
  int indexPage = 0;
  List<WeekEnergy> WeekEnergyData = [];
  List<MonthEnergy> MonthEnergyData = [];
  List<YearEnergy> YearEnergyData = [];
  int selectedIndex=0;
  num hour_diff = 0.0, min_diff = 0.0;
  List<Array6> chargingData = [];
/*  num charging_current = 0.0,
      charging_voltage = 0.0,
      charging_power = 0.0,
      overall_energy = 0.0;*/
  int TIMEDELAY = 10;
  int charging_state = 0,
      charging_fault_state = 0,
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
      firmwareVersion="Not available",
      wifi_ssid = "",
      wifi_pswd = "",
      apn_name = "",
      apn_pswd = "",
      security = "0",
      interface,
      app_mode = "",
      gsm_type = "0",
      chargername = "",
      chargertype,
      chargercapacity = "32 A",
      connectiontype;
  bool isScheduling = false, CurrentLog = true, isPaused = false;
  List<Array10> ChargerSummaryList = new List();
  Array10 array10 = new Array10();
  List<Array12> WeekEnergyList;

  List<Array12> MonthEnergyList;

  List<Array12> YearEnergyList;
  num energy,totalConsumptionWeek=0,totalConsumptionMonth=0,totalConsumptionYear=0;
  bool readyLoader = true,
      stopLoader = true,
      deleteCardLoader = false,
      ChargingSummaryLoader = false,
      EvAnalysisLoader = false,
      SettingsLoader = false,
      isResponse8 = false;
  List<Array33> rfidList=[];
  bool rfidShowLoader = false;
  StreamSubscription subscription;
  static Timer HeartBeatTimer;
  //bool HeartBeat;
  CommonResponse commonResponse = new CommonResponse();
  ResponseMsgId6 responseMsgId6 = new ResponseMsgId6();
  Properties6 responsePropertyMsgId6 = new Properties6();
  ResponseMsgId6Single responseMsgId6single = new ResponseMsgId6Single();
  Properties6Single responsePropertyMsgId6single = new Properties6Single();
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
  ResponseMsgId25 responseMsgId25 = new ResponseMsgId25();
  Properties25 responsePropertyMsgId25 = new Properties25();
  ResponseMsgId27 responseMsgId27 = new ResponseMsgId27();
  Properties27 responsePropertyMsgId27 = new Properties27();
  ResponseMsgId31 responseMsgId31 = new ResponseMsgId31();
  Properties31 responsePropertyMsgId31 = new Properties31();
  ResponseMsgId33 responseMsgId33 = new ResponseMsgId33();
  Properties33 responsePropertyMsgId33 = new Properties33();
  ResponseMsgId34 responseMsgId34 = new ResponseMsgId34();
  Properties34 responsePropertyMsgId34 = new Properties34();
  ResponseMsgId35 responseMsgId35 = ResponseMsgId35();

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
    indexPage = Index;
    notifyListeners();
  }

  void changeIndex(int i)
  {
     indexPage = i;
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

  bool setDeleteCardLoader(bool value)
  {
    deleteCardLoader = value;
    notifyListeners();
  }

  setChargeFault(int x)
  {
    charging_fault_state = x;
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
          if(response.length > 150) {
            responseMsgId6 = ResponseMsgId6.fromJson(jsonDecode(response));
            responsePropertyMsgId6 = responseMsgId6.properties;
            status = responsePropertyMsgId6.status;
            if (isResponse8 == false) CommonRequests(20);
            if (status != null) {
              CommonWidgets().showErrorSnackbar(context, status);
            } else {
              setChargingData(responsePropertyMsgId6.array);
              //charging_current = responsePropertyMsgId6.current;
              // charging_voltage = responsePropertyMsgId6.voltage;
              // charging_power = responsePropertyMsgId6.power;
              // overall_energy = responsePropertyMsgId6.sessionEnergy;
            }
          }else{
            responseMsgId6single = ResponseMsgId6Single.fromJson(jsonDecode(response));
            responsePropertyMsgId6single = responseMsgId6single.properties;
            status = responsePropertyMsgId6single.status;
            if (isResponse8 == false) CommonRequests(20);
            if (status != null) {
              CommonWidgets().showErrorSnackbar(context, status);
            } else {
              List<Array6> data = [];
              Array6 array = Array6(power:responsePropertyMsgId6single.power,current: responsePropertyMsgId6single.current,sessionEnergy: responsePropertyMsgId6single.sessionEnergy,
                          voltage: responsePropertyMsgId6single.voltage,phase: "1");
              data.add(array);
              setChargingData( data);
            }
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
            if(charging_state == 73)
              {
                 setChargeFault(responsePropertyMsgId8.chargingFaultState);
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
      case "24":
        try {
          commonResponse = CommonResponse.fromJson(jsonDecode(response));
          commonResponseProperty = commonResponse.properties;
          status = commonResponseProperty.status;
          if (status != 0) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            CommonRequests(25);
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "25":
        try {
          responseMsgId25 = ResponseMsgId25.fromJson(jsonDecode(response));
          responsePropertyMsgId25 = responseMsgId25.properties;
          status = responsePropertyMsgId25.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            wifi_ssid = responsePropertyMsgId25.ssid;
            wifi_pswd = responsePropertyMsgId25.pwd;
            setSettingsLoader(false);
            if (responsePropertyMsgId25.iType == "1")
              interface = "WIFI";
            else
              interface = "GSM";
            app_mode = responsePropertyMsgId25.appMode;
            apn_name = responsePropertyMsgId25.apn;
            apn_pswd = responsePropertyMsgId25.gsmPass;
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "26":
        try {
          commonResponse = CommonResponse.fromJson(jsonDecode(response));
          commonResponseProperty = commonResponse.properties;
          status = commonResponseProperty.status;
          if (status != 0) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            CommonRequests(27);
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      case "27":
        try {
          responseMsgId27 = ResponseMsgId27.fromJson(jsonDecode(response));
          responsePropertyMsgId27 = responseMsgId27.properties;
          status = responsePropertyMsgId27.status;
          if (status != null) {
            CommonWidgets().showErrorSnackbar(context, status);
          } else {
            chargername = responsePropertyMsgId27.chargerName;
            if (responsePropertyMsgId27.chargerCapacity == 16)
              chargercapacity = "16 A";
            else
              chargercapacity = "32 A";
            if (responsePropertyMsgId27.chargerType == 1)
              chargertype = "Single Phase";
            else
              chargertype = "Three Phase";
            if (responsePropertyMsgId27.connectionType == 1)
              connectiontype = "Socket";
            else
              connectiontype = "Cable";
            // Future.delayed(Duration(seconds: 2));
            // if (chargercapacity == '16 A')
            //   SendRequest13(13, 15);
            // else if (chargercapacity == '32 A')
            //   SendRequest13(13, 30);
            if( responsePropertyMsgId14 != null && responsePropertyMsgId14.maxCurrent > responsePropertyMsgId27.chargerCapacity)
              {
                SendRequest13(13, 15);
              }
            await Future.delayed(Duration(milliseconds: 500));
            CommonRequests(14);
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
          if(HeartBeatTimer !=null) {
            HeartBeatTimer.cancel();
          }
          responseMsgId31=null;
          print('null');
          HeartBeatTimer=Timer( const Duration(seconds: 10),
                () {
              print('after 10 sec');
              if(responseMsgId31==null){
                print('socket close');
                if (socket != null) {
                  socket.destroy();
                }
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
              {
                CommonWidgets().showToast('SuccessFully Added');
                Navigator.pop(context);
              }
            else if(responsePropertyMsgId34.errorcode == 2)
              {
                CommonWidgets().showToast('Already Added');
                Navigator.pop(context);
              }

            else if(responsePropertyMsgId34.errorcode == 3)
              {
                CommonWidgets().showToast('Timeout');
                Navigator.pop(context);
              }

            else if(responsePropertyMsgId34.errorcode == 4)
              {
                CommonWidgets().showToast('Full');
                Navigator.pop(context);
              }

            else if(responsePropertyMsgId34.errorcode == 5)
              {
                print("error code 5");
                setDeleteCardLoader(false);
                CommonWidgets().showToast("Successfully Deleted");
              }
            else
              {
                print("in else ");
              }
            CommonRequests(33);
          }
        } catch (e) {
          print("===Exception: " + msgId + " " + e.toString());
        }
        break;
      // case "35":
      //   {
      //     responseMsgId35 = ResponseMsgId35.fromJson(jsonDecode(response));
      //     print(" 35 rs");
      //     setDeleteCardLoader(false);
      //     if(responseMsgId35.properties.status == 1)
      //       {
      //          CommonWidgets().showToast("Successfully Deleted");
      //       }
      //     else if(responseMsgId35.properties.status == 3)
      //       {
      //         CommonWidgets().showToast("Timeout");
      //       }
      //   }
      //   break;
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

  Future<void> SendRequest3(int msgId, int chargingStartStop , String userName) async {
    try {
      RequestMsgId3 requestMsgId3 =
          RequestMsgId3.setData(msgId, chargingStartStop , userName);
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

  Future<void> SendRequest24(
      int msgId,
      String ssid,
      String pwd,
      String iType,
      String appMode,
      String security,
      String apn,
      String gsmPass,
      String gsmType,
      String networkswitchmode) async {
    try {
      RequestMsgId24 requestMsgId24 = RequestMsgId24.setData(
          msgId, ssid, pwd, iType, appMode, security, apn, gsmPass, gsmType,networkswitchmode);
      await sendMessage(socket, jsonEncode(requestMsgId24));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  Future<void> SendRequest26(int msgId, String chargername, String chargertype,
      String chargercapacity, String connectiontype) async {
    try {
      RequestMsgId26 requestMsgId26 = RequestMsgId26.setData(
          msgId, chargername, chargertype, chargercapacity, connectiontype);
      await sendMessage(socket, jsonEncode(requestMsgId26));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
    }
  }

  Future<void> SendRequest28(int msgId, String url) async {
    try {
      RequestMsgId28 requestMsgId28 = RequestMsgId28.setData(msgId, url);
      await sendMessage(socket, jsonEncode(requestMsgId28));
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


  Future<void> SendRequest35(int msgId, int action , String rfidTag) async {
    try {
      RequestMsgId35 requestMsgId35 = RequestMsgId35.setData(msgId, action , rfidTag , device_id);
      setDeleteCardLoader(true);
      await sendMessage(socket, jsonEncode(requestMsgId35));
    } on Exception catch (e) {
      print("===Exception:" + msgId.toString() + e.toString());
      setDeleteCardLoader(false);
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

  showFaultState(int chargeState)
  {
    if(charging_state == 73)
      {
        switch(chargeState)
        {
          case 1:
            {
              return "Full Charge";
            }
            break;
          case 2:
            {
              return "Gun Removed";
            }
            break;
          case 3:
            {
              return "FAULT_OCCURRED";
            }
            break;
          case 4:
            {
              return "Manual Stop";
            }
            break;
          case 5:
            {
              return "Power Loss";
            }
            break;
          case 6:
            {
              return "Charging Start";
            }
            break;
          case 7:
            {
              return "Other";
            }
            break;
          case 8:
            {
              return "Over Current";
            }
            break;
          case 9:
          {
            return "Over Voltage";
          }
          break;
          case 10:
          {
            return "Under Voltage";
          }
          break;
          case 11:
          {
            return "Zero Current";
          }
          break;
          case 12:
          {
            return "Emergency Stop";
          }
          break;
          case 13:
            {
              return "Earth Fault";
            }
            break;
          case 14:
            {
              return "Trip Stop";
            }
            break;
        }
      }
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
        String x = charging_fault_state != null ? showFaultState(charging_fault_state) : "";
        if(x.isNotEmpty)
          {
            return "Fault Occurred : $x";
          }
        else
          {
            return "There is a Fault.";
          }
      }
    }

    else if(auto_mode == 1) {
      String y = "Tips: Your Charger is in Plug and Play Mode";
      if (charging_state == 65) {
        return "$y\n\nPlease insert the Charging Gun";
      } else if (charging_state == 66) {
        return "Tips: Your Charger is in Plug and Play Mode";
      } else if (charging_state == 67) {
        return "";
      } else if (charging_state == 70) {
        return "";
      } else if (charging_state == 73) {
        String x = charging_fault_state != null ? showFaultState(charging_fault_state) : "";
        if(x.isNotEmpty)
        {
          return "$y?\n\nFault Occurred :? $x";
        }
        else
        {
          return "$y?\nThere is a Fault.";
        }
      }
    }

    else if(auto_mode == 2) {
      String y = "Tips: Your Charger is in RFID Mode";
      if (charging_state == 65) {
        return "$y\n\nPlease insert the Charging Gun";
      } else if (charging_state == 66) {
        return "Tips: Your Charger is in RFID Mode";
      } else if (charging_state == 67) {
        return "";
      } else if (charging_state == 70) {
        return "";
      } else if (charging_state == 73) {
        String x = charging_fault_state != null ? showFaultState(charging_fault_state) : "";
        if(x.isNotEmpty)
        {
          return "$y?\n\nFault Occurred :? $x";
        }
        else
        {
          return "$y?\nThere is a Fault.";
        }
      }
    }
    else if(auto_mode == 3) {
      return "Tips: Your Charger is in OCPP Mode";
    } else if(auto_mode == 4) {
      String y = "Tips: Your Charger is in Plug and Play Mode With Push Button";
      if (charging_state == 65) {
        return "$y\n\nPlease insert the Charging Gun";
      } else if (charging_state == 66) {
        return "Tips: Your Charger is in OCPP Mode";
      } else if (charging_state == 67) {
        return "";
      } else if (charging_state == 70) {
        return "";
      } else if (charging_state == 73) {
        String x = charging_fault_state != null ? showFaultState(charging_fault_state) : "";
        if(x.isNotEmpty)
        {
          return "$y?\n\nFault Occurred :? $x";
        }
        else
        {
          return "$y?\nThere is a Fault.";
        }
      }
    }
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
    if (auto_mode == 0 || auto_mode == 1 || auto_mode == 2 || auto_mode == 4) {
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
    if (auto_mode == 0 || auto_mode == 1 || auto_mode == 2 || auto_mode == 4 ) {
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
    }
    else {
      return false;
    }
    notifyListeners();
  }

  bool showStop() {
    if (auto_mode == 0) {
      if (charging_state == 65) {
        return true;
      } else if (charging_state == 66) {
        return true;
      } else if (charging_state == 67) {
        return true;
      } else if (charging_state == 70) {
        return false;
      } else if (charging_state == 73) {
        return true;
      }
    } else {
      return false;
    }
    notifyListeners();
  }

  bool isPausedCard() {
    if (auto_mode == 0|| auto_mode == 1 || auto_mode == 2 || auto_mode == 4) {
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

  void setSettingsLoader(bool Loader) {
    SettingsLoader = Loader;
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

  void setChargingData(List<Array6> data) {
    chargingData = data;
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
    // charging_current = 0;
    // charging_voltage = 0;
    // charging_power = 0;
    // overall_energy = 0;
    chargingData.clear();
    notifyListeners();
  }
}
