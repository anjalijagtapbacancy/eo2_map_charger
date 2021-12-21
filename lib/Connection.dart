
import 'package:eo2_map_charger/qr_scaner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ConstantFunction/custom_navigation.dart';
import 'Home.dart';


class Connection extends StatefulWidget {
  const Connection({Key key}) : super(key: key);

  @override
  connection createState() => connection();
}

class connection extends State<Connection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          InkWell(
            onTap: () {
              CustomNavigation.push(
                  context: context, className: QRViewExample());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: Container(
                child: Icon(Icons.qr_code_scanner),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Container(
            height: 50,
            child: Center(
              child: RaisedButton(
                textColor: Colors.black,
                color: Colors.white,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.navigate_next,
                          color: Colors.green,
                          size: 30,
                        ),
                        Text("Connect"),
                      ],
                    ),
                  ),
                ),
                onPressed: () {
                  CustomNavigation.push(context: context, className: Home());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
