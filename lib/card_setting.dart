import 'package:eo2_map_charger/CommonWidgets.dart';
import 'package:eo2_map_charger/ConstantFunction/size_constants.dart';
import 'package:eo2_map_charger/styles/common_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ConstantFunction/Constants.dart';
import 'VisibilityWidgets.dart';
import 'addCards.dart';

class CardSettings extends StatefulWidget {
  CardSettings();

  @override
  CardSettingsState createState() => CardSettingsState();
}

class CardSettingsState extends State<CardSettings> {
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;

  int selectedCard = -1;
  List<bool> isChecked = List.generate(5, (index) => false);

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
    });
      // TODO: implement initState
    super.initState();
  }

  showDeleteBottomSheet()
  {
    return showModalBottomSheet(context: context, builder: (ctx){
      return StatefulBuilder(builder: (ctx , setState){
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Manage cards"  ,style: TextStyle(fontSize: 17.sp),),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: visibilityWidgetsWatch.rfidList.length + 1 ,
                  itemBuilder: (ctx , i) {
                    if( i == visibilityWidgetsWatch.rfidList.length )
                    {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: CommonStyles.commonButtonStyle(context , color: Constants.blue),
                            child: Center(
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Constants.white),
                              ),
                            ),
                            onPressed: (){
                              if(selectedCard != -1 && selectedCard < visibilityWidgetsWatch.rfidList.length)
                              {
                                visibilityWidgetsWatch.SendRequest35(35 , 2, visibilityWidgetsWatch.rfidList.elementAt(selectedCard).idTag );
                                Navigator.pop(context);
                              }
                              else
                              {
                                CommonWidgets().showToast("Invalid Tag !");
                              }
                            }
                        ),
                      );
                    }
                    return visibilityWidgetsWatch.rfidList[i].idTag.isNotEmpty ?  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w , vertical: 12.h),
                      child:  Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black , width: 1),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                value: selectedCard == i ? true : false,
                                fillColor: MaterialStateProperty.all(Constants.blue),
                                shape: CircleBorder(),
                                onChanged: (bool value) {
                                  setState(() {
                                    selectedCard = i;
                                  });
                                },
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("EV Charging Card NO."),
                                  SizedBox(height: 5.h,),
                                  Text(visibilityWidgetsWatch.rfidList[i].idTag)
                                ],
                              ),
                            ],
                          ),
                        ) ,
                      ) ,
                    ): SizedBox() ;
                  }),
            ),
          ],
        );
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    return   SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('RFID Cards'),
            actions: [
              IconButton(onPressed: (){
                if(visibilityWidgetsWatch.rfidList.elementAt(0).idTag.trim().isNotEmpty)
                  {
                    showDeleteBottomSheet();
                  }
                else
                  {
                    CommonWidgets().showToast("No cards added!");
                  }

              }, icon: Icon(Icons.delete)),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,5,0),
                  child: Icon(Icons.add_outlined,color: Colors.white,),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCard()));
                },
              )
            ],),
          body: visibilityWidgetsWatch.deleteCardLoader ? CommonWidgets().CommonLoader(context) : visibilityWidgetsWatch.rfidList.length>0
          ? ListView.builder(
          physics:
          const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: visibilityWidgetsWatch.rfidList.length,
          itemBuilder:
              (context, index) {
            return showListOfrfidsInfo(index);
          })
          : Center(
            child: Text('No Card'),
          ),
    ));
  }

  Widget showListOfrfidsInfo(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Constants.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Text('Card ${index+1}',style: TextStyle(color: Colors.grey,fontSize: 17),),
            Text('${visibilityWidgetsWatch.rfidList[index].idTag}',style: TextStyle(color: Colors.green,fontSize: 18),),
          ],
        ),
      ),
    );
  }

}