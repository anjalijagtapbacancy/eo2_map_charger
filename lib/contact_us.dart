import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';

import 'ConstantFunction/Constants.dart';
import 'VisibilityWidgets.dart';

class ContactUs extends StatefulWidget {
  ContactUs();

  @override
  contact_us createState() => contact_us();
}

class contact_us extends State<ContactUs> {
  contact_us();
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    if(mounted && visibilityWidgetsWatch.responseMsgId8 != null)
      visibilityWidgetsWatch.Network(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Column(
          children: [
            Image.asset(AssetConstants.app_logo),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                "Address:",
                style: TextStyle(color: Colors.green),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                  "EO2 Evse Private Limited \n101-Labh,Shukan Tower, \nJudges Bunglow,Bodakdev, \nAhmedabad-380054, \nGujarat,India."),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                "Phone:",
                style: TextStyle(color: Colors.green),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text("+91-7574809625"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                "Email:",
                style: TextStyle(color: Colors.green),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text("info@eo2.in"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: Image.asset(AssetConstants.ic_facebook),
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(
                    child: Image.asset(AssetConstants.ic_twitter),
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(
                    child: Image.asset(AssetConstants.ic_linkedin),
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(
                    child: Image.asset(AssetConstants.ic_youtube),
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
