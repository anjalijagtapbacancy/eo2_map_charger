import 'dart:async';

import 'package:eo2_map_charger/ConstantFunction/custom_navigation.dart';
import 'package:eo2_map_charger/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'CommonWidgets.dart';
import 'ConstantFunction/Constants.dart';
import 'ConstantFunction/size_constants.dart';
import 'VisibilityWidgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  var flashState = flashOn;
  var cameraState = frontCamera;
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
    });
  }

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    SizeConstants.setScreenAwareConstant(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Stack(
                  children: [


                    MobileScanner(
                        allowDuplicates: false,
                        controller: MobileScannerController(torchEnabled: true),
                        onDetect: (barcode, args) async {
                          if (barcode.rawValue == null) {
                            debugPrint('Failed to scan Barcode');
                          } else {
                            final String code = barcode.rawValue;
                            debugPrint('Barcode found! $code');
                            visibilityWidgetsWatch.setQr(code);
                            CommonWidgets().showToast("MAC Address: $code");
                            final pref = await SharedPreferences.getInstance();
                            pref.setString("qrtxt", visibilityWidgetsRead.qrText);
                            Navigator.pop(context);
                            CustomNavigation.push(
                                context: context, className: Home());
                          }
                        }),

                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          //color: Colors.white,
                          child: Text(
                            visibilityWidgetsWatch.qrText,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: ScreenUtil().setHeight(80),
                          child: GestureDetector(
                            child: Icon(
                              Icons.close,
                              color: Constants.white,
                              size: 40,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 100),
                          child: Container(
                            child: Text(
                              Constants.qrCodeText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }
}

// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:provider/src/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'CommonWidgets.dart';
// import 'ConstantFunction/Constants.dart';
// import 'ConstantFunction/custom_navigation.dart';
// import 'ConstantFunction/size_constants.dart';
// import 'Home.dart';
// import 'VisibilityWidgets.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
//
// const flashOn = 'FLASH ON';
// const flashOff = 'FLASH OFF';
// const frontCamera = 'FRONT CAMERA';
// const backCamera = 'BACK CAMERA';
//
// class QRViewExample extends StatefulWidget {
//   const QRViewExample({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _QRViewExampleState();
// }
//
// class _QRViewExampleState extends State<QRViewExample> {
//   var flashState = flashOn;
//   var cameraState = frontCamera;
//   VisibilityWidgets visibilityWidgetsRead;
//   VisibilityWidgets visibilityWidgetsWatch;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       visibilityWidgetsRead = context.read<VisibilityWidgets>();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
//     SizeConstants.setScreenAwareConstant(context);
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: <Widget>[
//             Expanded(
//                 flex: 4,
//                 child: Stack(
//                   children: [
//
//
//                     MobileScanner(
//                         allowDuplicates: false,
//                         controller: MobileScannerController(torchEnabled: true),
//                         onDetect: (barcode, args) async {
//                           if (barcode.rawValue == null) {
//                             debugPrint('Failed to scan Barcode');
//                           } else {
//                             final String code = barcode.rawValue;
//                             debugPrint('Barcode found! $code');
//                             visibilityWidgetsWatch.setQr(code);
//                             CommonWidgets().showToast("MAC Address: $code");
//                             final pref = await SharedPreferences.getInstance();
//                             pref.setString("qrtxt", visibilityWidgetsRead.qrText);
//
//                             Navigator.pop(context);
//                             CustomNavigation.push(
//                                 context: context, className: Home());
//                           }
//                         }),
//
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: Padding(
//                         padding: EdgeInsets.only(top: 100),
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           //color: Colors.white,
//                           child: Text(
//                             visibilityWidgetsWatch.qrText,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
//                       child: Align(
//                         alignment: Alignment.topLeft,
//                         child: SizedBox(
//                           height: ScreenUtil().setHeight(80),
//                           child: GestureDetector(
//                             child: Icon(
//                               Icons.close,
//                               color: Constants.white,
//                               size: 40,
//                             ),
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Padding(
//                           padding: EdgeInsets.only(bottom: 100),
//                           child: Container(
//                             child: Text(
//                               Constants.qrCodeText,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//   @override
//   void dispose() {
//     //controller.dispose();
//     super.dispose();
//   }
// }



// // import 'dart:async';
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter/scheduler.dart';
// // import 'package:provider/src/provider.dart';
// // import 'package:qr_code_scanner/qr_code_scanner.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import 'CommonWidgets.dart';
// // import 'ConstantFunction/Constants.dart';
// // import 'ConstantFunction/custom_navigation.dart';
// // import 'Home.dart';
// // import 'VisibilityWidgets.dart';
// //
// // const flashOn = 'FLASH ON';
// // const flashOff = 'FLASH OFF';
// // const frontCamera = 'FRONT CAMERA';
// // const backCamera = 'BACK CAMERA';
// //
// // class QRViewExample extends StatefulWidget {
// //   const QRViewExample({
// //     Key key,
// //   }) : super(key: key);
// //
// //   @override
// //   State<StatefulWidget> createState() => _QRViewExampleState();
// // }
// //
// // class _QRViewExampleState extends State<QRViewExample> {
// //   var flashState = flashOn;
// //   var cameraState = frontCamera;
// //   QRViewController controller;
// //   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
// //   VisibilityWidgets visibilityWidgetsRead;
// //   VisibilityWidgets visibilityWidgetsWatch;
// //   StreamSubscription sub;
// //
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     SchedulerBinding.instance.addPostFrameCallback((_) {
// //       visibilityWidgetsRead = context.read<VisibilityWidgets>();
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
// //     return SafeArea(
// //       child: Scaffold(
// //         body: Column(
// //           children: <Widget>[
// //             Expanded(
// //                 flex: 4,
// //                 child: Stack(
// //                   children: [
// //                     _buildQrView(context),
// //                     Align(
// //                       alignment: Alignment.topCenter,
// //                       child: Padding(
// //                         padding: EdgeInsets.only(top: 100),
// //                         child: Container(
// //                           padding: EdgeInsets.all(10),
// //                           //color: Colors.white,
// //                           child: Text(
// //                             visibilityWidgetsWatch.qrText,
// //                             style: TextStyle(color: Colors.white),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     Align(
// //                       alignment: Alignment.bottomCenter,
// //                       child: Padding(
// //                         padding: EdgeInsets.only(bottom: 100),
// //                         child: Container(
// //                           child: Text(
// //                             Constants.qrCodeText,
// //                             style: TextStyle(
// //                                 color: Colors.white,
// //                                 fontWeight: FontWeight.bold),
// //                           ),
// //                         ),
// //                       ),
// //                     )
// //                   ],
// //                 )),
// //             Container(
// //               height: 60,
// //               width: 200,
// //               child: Center(
// //                 child: RaisedButton(
// //                   textColor: Colors.black,
// //                   color: Colors.white,
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(8.0),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: const [
// //                         Icon(
// //                           Icons.arrow_back_ios_rounded,
// //                           color: Colors.green,
// //                         ),
// //                         Text("Back"),
// //                       ],
// //                     ),
// //                   ),
// //                   onPressed: () {
// //                     Navigator.pop(context);
// //                   },
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(30.0),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildQrView(BuildContext context) {
// //     // To ensure the Scanner view is properly sizes after rotation
// //     // we need to listen for Flutter SizeChanged notification and update controller
// //     return NotificationListener<SizeChangedLayoutNotification>(
// //         onNotification: (notification) {
// //           Future.microtask(() => controller?.updateDimensions(qrKey));
// //           return false;
// //         },
// //         child: SizeChangedLayoutNotifier(
// //             key: const Key('qr-size-notifier'),
// //             child: QRView(
// //               key: qrKey,
// //               onQRViewCreated: _onQRViewCreated,
// //               overlay: QrScannerOverlayShape(
// //                 borderColor: Colors.white,
// //                 borderRadius: 10,
// //                 borderLength: 30,
// //                 borderWidth: 6,
// //                 cutOutSize: 200,
// //               ),
// //             )));
// //   }
// //
// //   void _onQRViewCreated(QRViewController controller) {
// //     this.controller = controller;
// //     sub = controller.scannedDataStream.listen((scanData) async {
// //       if (scanData.isNotEmpty) {
// //         visibilityWidgetsWatch.setQr(scanData);
// //         sub.cancel();
// //         CommonWidgets().showToast("MAC Address: $scanData");
// //         final pref = await SharedPreferences.getInstance();
// //         pref.setString("qrtxt", visibilityWidgetsRead.qrText);
// //         Navigator.pop(context);
// //         CustomNavigation.push(
// //             context: context, className: Home());
// //       }
// //     });
// //   }
// //
// //   @override
// //   void dispose() {
// //     controller.dispose();
// //     super.dispose();
// //   }
// // }
