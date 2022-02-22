import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_settings/app_settings.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:multicast_dns/multicast_dns.dart';

import 'CommonWidgets.dart';
import 'Connection.dart';
import 'VisibilityWidgets.dart';
import 'package:provider/provider.dart';

Future<void> ConnectServer(BuildContext context1) async {
  VisibilityWidgets visibilityWidgetsRead;
  InternetAddress ServerIp;
  Socket socket;
  MDnsClient client;

    print("object");
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      visibilityWidgetsRead = context1.read<VisibilityWidgets>();
      print("${visibilityWidgetsRead.qrText}");
      try {
        String name = '${visibilityWidgetsRead.qrText}.local';
        if (Platform.isIOS) {
          client = MDnsClient();
        } else {
          client = MDnsClient(rawDatagramSocketFactory:
              (dynamic host, int port,
              {bool reuseAddress, bool reusePort, int ttl}) {
            return RawDatagramSocket.bind(host, port,
                reuseAddress: true, reusePort: false, ttl: ttl);
          });
        }
        if (client != null) {
          await client.start();
          await for (IPAddressResourceRecord record
          in client.lookup<IPAddressResourceRecord>(
              ResourceRecordQuery.addressIPv4(name),
              timeout: Duration(milliseconds: 2000))) {
            ServerIp = record.address;
            print('Found address (${record.address}).');
            client.stop();
          }
        }
        if (ServerIp != null) {
          socket = await Socket.connect(
              ServerIp, 8080, timeout: Duration(seconds: 1)).timeout(
              Duration(seconds: 1), onTimeout: () {
            CommonWidgets().showToast("Connection Error");
          });
          visibilityWidgetsRead.setsocket(socket);
          // timer = Timer.periodic(Duration(seconds: 5), (Timer t) => checkConnectionStatus());
        }
        if (visibilityWidgetsRead.socket != null) {
          print(
              'Connected to: ${visibilityWidgetsRead.socket.remoteAddress
                  .address}:${visibilityWidgetsRead.socket.remotePort}');
          visibilityWidgetsRead.isrunning = true;
          visibilityWidgetsRead.socket.listen(
                (Uint8List data) {
              /* String serverResponse =
              "{\"msg_id\":12,\"properties\": {\"type\": 3,\"array\": [{\"energy\": 3444},{\"energy\": 3454},{\"energy\": 7888},{\"energy\": 5455},{\"energy\": 6465},{\"energy\": 8888},{\"energy\": 7777},{\"energy\": 3444},{\"energy\": 8888},{\"energy\": 8655},{\"energy\": 3333},{\"energy\": 6666},{\"energy\": 6677},{\"energy\": 7655},{\"energy\": 3333},{\"energy\": 3333},{\"energy\": 9999},{\"energy\": 1666},{\"energy\": 2545},{\"energy\": 9899},{\"energy\": 6656},{\"energy\": 3466},{\"energy\": 3567},{\"energy\": 7655},{\"energy\": 7898},{\"energy\": 4557},{\"energy\": 8878},{\"energy\": 3233},{\"energy\": 5678},{\"energy\": 5553}]}}\n\r";
        */
              String serverResponse = String.fromCharCodes(data);
              if (serverResponse.contains("{\"msg_id\":")) {
                List<String> Message = [];
                final split = serverResponse.split("\n\r");
                for (int i = 0; i < split.length - 1; i++) {
                  if (split[i].contains("{\"msg_id\":")) Message.add(
                      split[i]);
                }
                for (var value in Message) {
                  print(value);
                  String splitString = value.split("{\"msg_id\":")[1];
                  String msgId = splitString.split(",")[0];
                  visibilityWidgetsRead.setResponse(context1, value, msgId);
                }
              }
            }, cancelOnError: true,
            onError: (error) async {
              print("Error===" + error.toString());
              visibilityWidgetsRead.socket.destroy();
              visibilityWidgetsRead.responseMsgId8 = null;
              if (context1 != null)
                Navigator.of(context1).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context1) => Connection()),
                        (Route<dynamic> route) => false);
            },
            onDone: () {
              try {
                print('Server left.');
                visibilityWidgetsRead.responseMsgId8 = null;
                if (visibilityWidgetsRead.socket != null)
                  visibilityWidgetsRead.socket.destroy();
                if (context1 != null)
                  Navigator.of(context1).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context1) => Connection()),
                          (Route<dynamic> route) => false);
              } catch (Exception) {
                print("Exception==onDone ${Exception.toString()}");
              }
            },
          );
          visibilityWidgetsRead.SendRequest1(1, EpochTime());
          await Future.delayed(Duration(milliseconds: 500));
          visibilityWidgetsRead.CommonRequests(20);
        }
        // else {
        //   print("Something Wrong with Ip Address");
        //   CommonWidgets().showToast("Ip Address Not Found");
        //   if (context1 != null)
        //     Navigator.of(context1).pushAndRemoveUntil(
        //         MaterialPageRoute(builder: (context1) => Connection()),
        //             (Route<dynamic> route) => false);
        // }
      } catch (e) {
        print("Exception" + e.toString());
      }
    });

}

int EpochTime() {
  int Epoch_time =
  ((DateTime
      .now()
      .millisecondsSinceEpoch) / 1000).ceil() as int;
  return Epoch_time;
}

Future<void> sendMessage(Socket socket, String message) async {
  print('Client: $message');
  socket.write(message);
  await Future.delayed(Duration(milliseconds: 500));
}
