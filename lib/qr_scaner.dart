import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'CommonWidgets.dart';
import 'ConstantFunction/Constants.dart';
import 'ConstantFunction/custom_navigation.dart';
import 'ConstantFunction/size_constants.dart';
import 'Home.dart';
import 'VisibilityWidgets.dart';

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
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;
  StreamSubscription sub;

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
                    _buildQrView(context),
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
                            child: GestureDetector(child: Icon(Icons.close,color:Constants.white,size: 40,),onTap: (){
                              Navigator.pop(context);
                            },),
                          ),
                        ),
                    ),
                    Align(
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
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (notification) {
          Future.microtask(() => controller?.updateDimensions(qrKey));
          return false;
        },
        child: SizeChangedLayoutNotifier(
            key: const Key('qr-size-notifier'),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Constants.green,
                  borderRadius: 10,
                  borderLength: 40,
                  borderWidth: 6,
                  cutOutSize: 400.sp,
                ),
              ),
            )));
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    sub = controller.scannedDataStream.listen((scanData) async {
      if (scanData.isNotEmpty) {
        visibilityWidgetsWatch.setQr(scanData);
        sub.cancel();
        CommonWidgets().showToast("MAC Address: $scanData");
        final pref = await SharedPreferences.getInstance();
        pref.setString("qrtxt", visibilityWidgetsRead.qrText);
        Navigator.pop(context);
        CustomNavigation.push(
            context: context, className: Home());
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
