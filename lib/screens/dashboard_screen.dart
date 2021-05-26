import 'package:Gadget_Doctor_MobileApp/screens/gadget_community_screen.dart';
import 'package:Gadget_Doctor_MobileApp/screens/gadget_expert_screen.dart';
import 'package:Gadget_Doctor_MobileApp/screens/gadget_market_screen.dart';
import 'package:Gadget_Doctor_MobileApp/widgets/gadget_market_card.dart';
import 'package:Gadget_Doctor_MobileApp/widgets/task_count_card.dart';
import 'package:Gadget_Doctor_MobileApp/widgets/task_list_card.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:Gadget_Doctor_MobileApp/services/auth_service.dart';
import 'package:Gadget_Doctor_MobileApp/widgets/dashboard_card.dart';
import 'package:Gadget_Doctor_MobileApp/widgets/scroll_glow_disabler.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  final String vehicleID;
  DashboardScreen({@required this.vehicleID});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference vehicleData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Theme(
        //* Side drawer ---------------------------------------------------------------------------------------------
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Color(
              0xaa141c3d), //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: Drawer(
          child: Column(
            // Important: Remove any padding from the ListView.
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100,
                width: double.infinity,
                child: DrawerHeader(
                  child: Text(
                    //* Drawer header
                    'Gadget Doctor',
                    style: TextStyle(
                        fontFamily: 'sf',
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff141c3d),
                  ),
                ),
              ),
              ListTile(
                tileColor: Color(0xff8E45AE),
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                title: Text(
                  'Dashboard',
                  style: TextStyle(
                      fontFamily: 'sf', fontSize: 22, color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.add_business,
                  color: Colors.white,
                ),
                title: Text(
                  'Gadget Market',
                  style: TextStyle(
                      fontFamily: 'sf', fontSize: 22, color: Colors.white),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          GadgetMarketScreen(vehicleID: widget.vehicleID),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.group,
                  color: Colors.white,
                ),
                title: Text(
                  'Gadget Community',
                  style: TextStyle(
                      fontFamily: 'sf', fontSize: 22, color: Colors.white),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          GadgetCommunityScreen(vehicleID: widget.vehicleID),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.admin_panel_settings,
                  color: Colors.white,
                ),
                title: Text(
                  'Gadget Expert',
                  style: TextStyle(
                      fontFamily: 'sf', fontSize: 22, color: Colors.white),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          GadgetExpertScreen(vehicleID: widget.vehicleID),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.web,
                  color: Colors.white,
                ),
                title: Text(
                  'Gadget Website',
                  style: TextStyle(
                      fontFamily: 'sf', fontSize: 22, color: Colors.white),
                ),
                onTap: () async {
                  await canLaunch('https://www.gadgetdoc.tech')
                      ? await launch('https://www.gadgetdoc.tech')
                      : throw 'Could not launch https://www.gadgetdoc.tech';
                  Navigator.pop(context);
                },
              ),
              Expanded(
                //* Sign Out button
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                    title: Text(
                      'Sign Out',
                      style: TextStyle(
                          fontFamily: 'sf', fontSize: 22, color: Colors.white),
                    ),
                    onTap: () {
                      AuthService().signOut(context);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        //* Background Image
        padding: EdgeInsets.fromLTRB(15, 35, 15, 6),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/assets/background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(children: [
              InkWell(
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 35,
                ),
                onTap: () => scaffoldKey.currentState.openDrawer(),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Dashboard',
                style: TextStyle(
                    fontFamily: 'sf',
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Card(
                  //* Selected Vehicle Card -----------------------------------------------------------------------------------
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  color: Colors.black54,
                  elevation: 0,
                  child: ScrollGlowDisabler(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      child: Container(
                        // padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                        width: double.infinity,
                        child: StreamBuilder(
                          //* Get data from firestore -------------------------------------------------------------------------
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(auth.currentUser.uid)
                              .collection('Vehicles')
                              .doc(widget.vehicleID)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading");
                            }

                            var userDocument = snapshot.data;
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  userDocument['Brand'] +
                                      ' ' +
                                      userDocument['Model'] +
                                      ' : ' +
                                      userDocument['Vehicle'],
                                  style: TextStyle(
                                    fontFamily: 'sf',
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                                DashboardCard(
                                  topicText: 'Mileage',
                                  detailText: userDocument['mileage'] + 'KM',
                                  bottomText: 'Last Synced on: ' +
                                      userDocument['lastSynced'],
                                  buttonText: 'Update Current Mileage',
                                  color: Colors.green,
                                  mainIcon: Icons.directions_car,
                                  bottomIcon: Icons.calendar_today_outlined,
                                  editFunction: () {
                                    _editPopup(
                                        topicText: 'Update Mileage',
                                        textField: 'Enter Your Current Mileage',
                                        errorText: 'Enter Mileage',
                                        isCurrentMileage: true);
                                  },
                                ),
                                DashboardCard(
                                  topicText: 'Next Service',
                                  detailText: (int.parse(userDocument[
                                                  'LastServiceMileage']) +
                                              5000)
                                          .toString() +
                                      'KM',
                                  bottomText: 'On or Before: ' +
                                      DateFormat("yyyy-MM-dd")
                                          .format(DateTime(
                                              (DateTime.parse(userDocument[
                                                      'LastServiceDate']))
                                                  .year,
                                              (DateTime.parse(userDocument[
                                                          'LastServiceDate']))
                                                      .month +
                                                  6,
                                              (DateTime.parse(userDocument[
                                                      'LastServiceDate']))
                                                  .day))
                                          .toString(),
                                  buttonText: 'Update Service Mileage',
                                  color: Colors.cyan,
                                  mainIcon: Icons.handyman,
                                  bottomIcon: Icons.calendar_today_outlined,
                                  editFunction: () {
                                    _editPopup(
                                        topicText: 'Update Service Mileage',
                                        textField:
                                            'Enter Mileage at Service Date',
                                        errorText: 'Enter Mileage',
                                        isCurrentMileage: false);
                                  },
                                ),
                                TaskCountCard(
                                  topicText: 'Completed',
                                  bottomText: 'Tracked from suggestions',
                                  vehicleNo: userDocument['Vehicle'],
                                  color: Colors.cyan,
                                  mainIcon: Icons.done_outline_rounded,
                                  bottomIcon: Icons.label,
                                ),
                                TaskCountCard(
                                  topicText: 'Warnings',
                                  bottomText: 'Tracked from suggestions',
                                  vehicleNo: userDocument['Vehicle'],
                                  color: Colors.red,
                                  mainIcon: Icons.info_outline,
                                  bottomIcon: Icons.label,
                                ),

                                TaskListCard(
                                  model: userDocument['Model'],
                                  vehicleNumber: userDocument['Vehicle'],
                                  mileage: int.parse(userDocument['mileage']),
                                ),
                                GadgetMarketCard(),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _editPopup({topicText, textField, errorText, isCurrentMileage}) {
    final currentMileage = TextEditingController();
    bool enterAllError = false;

    //* Vehicle register alert -------------------------------------------------------------------------------------
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: StatefulBuilder(
            builder: (context, StateSetter setState) {
              return Container(
                width: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 15, right: 15),
                        child: Text(
                            //* Text ----------------------------------------------------------------------------------------
                            topicText,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'sf', fontSize: 20)),
                      ),
                    ),
                    Container(
                      //* Current mileage TextField -----------------------------------------------------------------------------------
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      // alignment: Alignment.topLeft,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            enterAllError = false;
                          });
                        },
                        keyboardType: TextInputType.number,
                        controller: currentMileage,
                        style: TextStyle(
                            fontFamily: 'sf',
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                        decoration: new InputDecoration(
                          labelText: textField,
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          contentPadding:
                              EdgeInsets.only(left: 10, top: 5, bottom: 10),
                          fillColor: Colors.grey[300],
                          // counter: SizedBox.shrink(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color(0xff03e9f4), width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Color(0xff03e9f4), width: 2),
                          ),
                        ),
                      ),
                    ),
                    (enterAllError)
                        ? Container(
                            //* Error message Text -------------------------------------------------------------------------------
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              errorText,
                              style: TextStyle(
                                  fontFamily: 'sf',
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        : SizedBox(
                            height: 15,
                          ),
                    Divider(
                      height: 2.0,
                    ),
                    InkWell(
                      //* Update Button ---------------------------------------------------------------------------------------
                      child: Container(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        decoration: BoxDecoration(
                          color: Color(0xff03e9f4),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                        ),
                        child: Text(
                          'Update Data',
                          style: TextStyle(
                              fontFamily: 'sf',
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        if (currentMileage.text == '') {
                          setState(() {
                            enterAllError = true;
                          });
                        } else if (isCurrentMileage) {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(auth.currentUser.uid)
                              .collection('Vehicles')
                              .doc(widget.vehicleID)
                              .update({
                            'mileage': '${currentMileage.text}',
                            'lastSynced':
                                '${DateFormat("yyyy-MM-dd").format(DateTime.now())}'
                          });
                          Navigator.pop(context);
                        } else {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(auth.currentUser.uid)
                              .collection('Vehicles')
                              .doc(widget.vehicleID)
                              .update({
                            'LastServiceMileage': '${currentMileage.text}',
                            'LastServiceDate':
                                '${DateFormat("yyyy-MM-dd").format(DateTime.now())}'
                          });
                          Navigator.pop(context);
                        }
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
