import 'package:Gadget_Doctor_MobileApp/screens/select_vehicle_screen.dart';
import 'package:Gadget_Doctor_MobileApp/widgets/dismiss_keyboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:Gadget_Doctor_MobileApp/widgets/scroll_glow_disabler.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddVehicleScreen extends StatefulWidget {
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final vehicleColour = TextEditingController();
  final vehicleNumber = TextEditingController();
  final currentMileage = TextEditingController();
  final mileageLastService = TextEditingController();
  final dateLastService = TextEditingController();

  ScrollController _scrollController = ScrollController();
  static DateTime _getDate = DateTime.now();
  String dateFormatted;
  String selectedBrand;
  String selectedModel;
  String selectedYear;
  bool enterAllError = false;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
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
            Text(
              'Gadget Doctor',
              style: TextStyle(
                  fontFamily: 'sf',
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
                width: double.infinity,
                child: Card(
                  //* Register Vehicle Card ------------------------------------------------------------------------------------------------
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  color: Colors.black54,
                  elevation: 0,
                  child: ScrollGlowDisabler(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      padding: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: bottom, top: 0),
                        child: Container(
                          // padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                          width: double.infinity,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Register Your Vehicle',
                                style: TextStyle(
                                    fontFamily: 'sf',
                                    fontSize: 22,
                                    color: Colors.white),
                              ),
                              Container(
                                //* Select brand Dropdown ----------------------------------------------------------------------
                                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                                width: double.infinity,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(top: 5, bottom: 10),
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sf',
                                      fontSize: 18,
                                    ),
                                    filled: true,
                                    labelText: 'Brand',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                  dropdownColor: Color(0xff141c3d),
                                  iconEnabledColor: Colors.white,
                                  items: <String>[
                                    'Honda',
                                    'Nissan',
                                    'Toyota',
                                    'BMW'
                                  ].map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(
                                        value,
                                        style: TextStyle(
                                            fontFamily: 'sf',
                                            fontSize: 18,
                                            color: Colors.white,
                                            //     : Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    );
                                  }).toList(),
                                  value: selectedBrand,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        selectedBrand = value;
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                //* Select model Dropdown ----------------------------------------------------------------------
                                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                                width: double.infinity,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(top: 5, bottom: 10),
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sf',
                                      fontSize: 18,
                                    ),
                                    filled: true,
                                    labelText: 'Model',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                  dropdownColor: Color(0xff141c3d),
                                  iconEnabledColor: Colors.white,
                                  items: <String>[
                                    'Grace',
                                    'Corolla',
                                    'Leaf',
                                    'Sunny'
                                  ].map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(
                                        value,
                                        style: TextStyle(
                                            fontFamily: 'sf',
                                            fontSize: 18,
                                            color: Colors.white,
                                            //     : Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    );
                                  }).toList(),
                                  value: selectedModel,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        selectedModel = value;
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                //* Select year Dropdown ----------------------------------------------------------------------
                                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                                width: double.infinity,
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(top: 5, bottom: 10),
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sf',
                                      fontSize: 18,
                                    ),
                                    filled: true,
                                    labelText: 'Model Year',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                  dropdownColor: Color(0xff141c3d),
                                  iconEnabledColor: Colors.white,
                                  items: <String>[
                                    '2022',
                                    '2021',
                                    '2020',
                                    '2019',
                                    '2018',
                                    '2017',
                                    '2016',
                                    '2015',
                                    '2014',
                                    '2013',
                                    '2012',
                                    '2011',
                                    '2010'
                                  ].map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(
                                        value,
                                        style: TextStyle(
                                            fontFamily: 'sf',
                                            fontSize: 18,
                                            color: Colors.white,
                                            //     : Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    );
                                  }).toList(),
                                  value: selectedYear,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        selectedYear = value;
                                      },
                                    );
                                  },
                                ),
                              ),
                              Container(
                                //* Vehicle Colour TextField -----------------------------------------------------------------------------------
                                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                                // alignment: Alignment.topLeft,
                                child: TextField(
                                  controller: vehicleColour,
                                  style: TextStyle(
                                      fontFamily: 'sf',
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                  decoration: new InputDecoration(
                                    labelText: 'Vehicle Colour',
                                    labelStyle: TextStyle(color: Colors.white),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.only(top: 5, bottom: 10),
                                    // counter: SizedBox.shrink(),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color(0xff03e9f4), width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                //* Vehicle number TextField -----------------------------------------------------------------------------------
                                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                                // alignment: Alignment.topLeft,
                                child: TextField(
                                  controller: vehicleNumber,
                                  style: TextStyle(
                                      fontFamily: 'sf',
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                  decoration: new InputDecoration(
                                    labelText: 'Vehicle Number',
                                    labelStyle: TextStyle(color: Colors.white),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.only(top: 5, bottom: 10),
                                    // counter: SizedBox.shrink(),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color(0xff03e9f4), width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                //* Current mileage TextField -----------------------------------------------------------------------------------
                                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                                // alignment: Alignment.topLeft,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: currentMileage,
                                  style: TextStyle(
                                      fontFamily: 'sf',
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                  decoration: new InputDecoration(
                                    labelText: 'Current Mileage',
                                    labelStyle: TextStyle(color: Colors.white),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.only(top: 5, bottom: 10),
                                    // counter: SizedBox.shrink(),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color(0xff03e9f4), width: 2),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                //* Mileage at last service TextField -----------------------------------------------------------------------------------
                                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                                // alignment: Alignment.topLeft,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: mileageLastService,
                                  style: TextStyle(
                                      fontFamily: 'sf',
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                  decoration: new InputDecoration(
                                    labelText: 'Mileage at Last Service',
                                    labelStyle: TextStyle(color: Colors.white),
                                    filled: true,
                                    contentPadding:
                                        EdgeInsets.only(top: 5, bottom: 10),
                                    // counter: SizedBox.shrink(),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color(0xff03e9f4), width: 2),
                                    ),
                                  ),
                                  // onTap: () {
                                  //   Timer(
                                  //     Duration(milliseconds: 200),
                                  //     () => _scrollController.jumpTo(
                                  //         _scrollController
                                  //             .position.maxScrollExtent),
                                  //   );
                                  // },
                                ),
                              ),
                              Container(
                                //* Date of last service TextField -----------------------------------------------------------------------------------
                                padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                                // alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 4,
                                      fit: FlexFit.tight,
                                      child: TextField(
                                        enabled: false,
                                        controller: dateFormatted == null
                                            ? TextEditingController(text: '')
                                            : TextEditingController(
                                                text: dateFormatted),
                                        // controller: password,
                                        style: TextStyle(
                                            fontFamily: 'sf',
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                        decoration: new InputDecoration(
                                          labelText: 'Date of Last Service',
                                          labelStyle:
                                              TextStyle(color: Colors.white),
                                          filled: true,
                                          contentPadding: EdgeInsets.only(
                                              top: 5, bottom: 10),
                                          // counter: SizedBox.shrink(),
                                          disabledBorder: UnderlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.white, width: 2),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: RaisedButton(
                                        // height: double.infinity,
                                        child: Container(
                                            child: Icon(
                                          Icons.calendar_today_rounded,
                                          color: Colors.white,
                                        )),
                                        elevation: 4,
                                        // highlightColor: SharedData.buttonHighlightColor,
                                        color: Color(0xff03e9f4),
                                        padding:
                                            EdgeInsets.fromLTRB(15, 14, 15, 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                        ),
                                        onPressed: () {
                                          dismissKeyboard(context);
                                          showDatePicker(
                                            context: context,
                                            initialDate: _getDate,
                                            firstDate: DateTime(2010),
                                            lastDate: DateTime.now(),
                                          ).then(
                                            (dob) {
                                              (dob != null)
                                                  ? setState(
                                                      () {
                                                        print(dob);
                                                        _getDate = dob;
                                                        dateFormatted =
                                                            new DateFormat(
                                                                    "yyyy-MM-dd")
                                                                .format(
                                                                    _getDate);
                                                      },
                                                    )
                                                  : print('Date not set');
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              (enterAllError
                                  ? Container(
                                      //* Error message Text -------------------------------------------------------------------------------
                                      padding:
                                          EdgeInsets.fromLTRB(30, 15, 30, 0),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Enter all details correctly',
                                        style: TextStyle(
                                            fontFamily: 'sf',
                                            fontSize: 15,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 15,
                                    )),
                              Container(
                                //* Add my car Button ----------------------------------------------------------------------------------
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.fromLTRB(30, 10, 30, 8),
                                child: RaisedButton(
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        'Add My Car',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'sf',
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                        //width: double.infinity,
                                      ),
                                    ),
                                    elevation: 4,
                                    // highlightColor: SharedData.buttonHighlightColor,
                                    color: Color(0xff03e9f4),
                                    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                    ),
                                    onPressed: () async {
                                      if (selectedBrand == null ||
                                          selectedModel == null ||
                                          selectedYear == null ||
                                          vehicleColour.text == '' ||
                                          vehicleNumber.text == '' ||
                                          currentMileage.text == '' ||
                                          mileageLastService.text == '' ||
                                          dateFormatted == null) {
                                        setState(() {
                                          enterAllError = true;
                                        });
                                      } else {
                                        _sucessAlert(context: context);
                                        setState(() {
                                          enterAllError = false;
                                        });
                                      }
                                    }),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
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

  _addMyCar() {
    //* Add vehicle to firestore -------------------------------------------------------------------------------------
    FirebaseAuth auth = FirebaseAuth.instance;
    print(selectedBrand);
    print(selectedModel);
    print(vehicleColour.text);
    print(vehicleNumber.text);
    print(currentMileage.text);
    print(mileageLastService.text);
    print(
        '${DateFormat("E MMM dd yyyy HH:mm:ss").format(_getDate)} GMT+0530 (India Standard Time)');
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser.uid)
        .collection('Vehicles')
        .doc()
        .set({
      'Brand': '$selectedBrand',
      'Model': '$selectedModel',
      'car': '$selectedModel',
      'Year': '$selectedYear',
      'Colour': '${vehicleColour.text}',
      'Vehicle': '${vehicleNumber.text}',
      'mileage': '${currentMileage.text}',
      'LastServiceMileage': '${mileageLastService.text}',
      'LastServiceDate': '$dateFormatted',
      'lastSynced': '$dateFormatted',
      'datetime': '${DateFormat("yyyy-MM-dd").format(DateTime.now())}',
    });
  }

  _sucessAlert({@required context}) {
    //* Vehicle register alert -------------------------------------------------------------------------------------
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
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
                        'Vehicle Registered Sucessfully',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'sf', fontSize: 20)),
                  ),
                ),
                Divider(
                  height: 2.0,
                ),
                InkWell(
                  //* Close Button ---------------------------------------------------------------------------------------
                  child: Container(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    decoration: BoxDecoration(
                      color: Color(0xff03e9f4),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)),
                    ),
                    child: Text(
                      'Return to vehicle list',
                      style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    _addMyCar();

                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                SelectVehicleScreen(),
                            transitionDuration: Duration(seconds: 0)),
                        (Route<dynamic> route) => false);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
