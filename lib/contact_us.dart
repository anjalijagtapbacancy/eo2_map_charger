import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ConstantFunction/Constants.dart';
import 'ConstantFunction/size_constants.dart';
import 'VisibilityWidgets.dart';
import 'package:url_launcher/url_launcher.dart';

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
      visibilityWidgetsRead.setappbar_name("Contact Us");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    SizeConstants.setScreenAwareConstant(context);
    if(mounted && visibilityWidgetsWatch.responseMsgId8 != null)
      visibilityWidgetsWatch.Network(context);
    return Scaffold(
      backgroundColor: Constants.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Column(
            children: [
              Image.asset(AssetConstants.app_logo),
              SizedBox(height: ScreenUtil().setHeight(15),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                " Phone",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text("+91-7574809624"),
                            ),
                          ],
                        ),
                        InkWell(child: Image.asset(AssetConstants.phone),
                            onTap: () => launch('tel://+91-7574809624'),),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: new Border.all(
                      color: Colors.grey[300],
                      width: 1,
                    ),),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(15),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                " Email",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text("info@eo2.in"),
                            ),
                          ],
                        ),
                        InkWell(child: Image.asset(AssetConstants.email),
                          onTap: () => launch('mailto:info@eo2.in'),),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: new Border.all(
                      color: Colors.grey[300],
                      width: 1,
                    ),),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(15),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                " Website",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text("eo2.in"),
                            ),
                          ],
                        ),
                        InkWell(child: Image.asset(AssetConstants.website),
                          onTap: () => launch('http://eo2.in'),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: new Border.all(
                      color: Colors.grey[300],
                      width: 1,
                    ),),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15,0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: Image.asset(AssetConstants.ic_facebook),
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setHeight(50),
                    ),
                    SizedBox(
                      child: Image.asset(AssetConstants.ic_twitter),
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setHeight(50),
                    ),
                    SizedBox(
                      child: Image.asset(AssetConstants.ic_linkedin),
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setHeight(50),
                    ),
                    SizedBox(
                      child: Image.asset(AssetConstants.ic_youtube),
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setHeight(50),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
