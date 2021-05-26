import 'package:Gadget_Doctor_MobileApp/screens/market_webview_screen.dart';
import 'package:Gadget_Doctor_MobileApp/screens/task_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Data>> fetchData() async {
  final response =
      await http.get('https://market.gadgetdoc.tech/wp-json/wc/store/products');
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  final String name;
  final String price;
  final String link;

  Data({this.name, this.price, this.link});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'],
      price: json['prices']['price'].toString(),
      link: json['permalink'],
    );
  }
}

class TaskListCard extends StatefulWidget {
  final String model;
  final String vehicleNumber;
  final int mileage;
  TaskListCard(
      {@required this.model,
      @required this.vehicleNumber,
      @required this.mileage});

  @override
  _TaskListCardState createState() => _TaskListCardState();
}

class _TaskListCardState extends State<TaskListCard> {
  Future<List<Data>> futureData;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    setTasks();
    futureData = fetchData();
  }

  setTasks() async {
    //* Copy tasks from vehicle to history collection
    var firestoreInstance = FirebaseFirestore.instance;
    try {
      //* Check if tasks already available
      var value = await FirebaseFirestore.instance
          .collection('history')
          .doc(auth.currentUser.uid)
          .collection(widget.vehicleNumber)
          .limit(1)
          .get();
      if (!value.docs.isNotEmpty) {
        //* if not available
        //* Get the tasks from vehicle collection
        await firestoreInstance
            .collection("vehicles")
            .doc('Suggessions')
            .collection(widget.model)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((result) {
            //* Add tasks to history collection
            firestoreInstance
                .collection('history')
                .doc(auth.currentUser.uid)
                .collection(widget.vehicleNumber)
                .doc()
                .set(result.data());
            print(result.data);
          });
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, 35, 20, 8),
          child: Card(
            //* White Details Card ----------------------------------------------------------------------
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            color: Colors.white,
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 75, bottom: 10),
                  width: double.infinity,
                  child: Center(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('history')
                          .doc(auth.currentUser.uid)
                          .collection(widget.vehicleNumber)
                          .where('mileage',
                              isGreaterThanOrEqualTo: widget.mileage - 5000)
                          .where('mileage',
                              isLessThanOrEqualTo: widget.mileage + 10000)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                // DocumentSnapshot data =
                                //     snapshot.data[index].data();
                                return Container(
                                  padding: EdgeInsets.fromLTRB(12, 10, 12, 5),
                                  child: Card(
                                    //* White Task Card ----------------------------------------------------------------------
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    color: Colors.grey[300],
                                    elevation: 0,
                                    child: InkWell(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(12, 8, 12, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              (snapshot.data.docs[index]
                                                          ['status'] ==
                                                      'pending_actions')
                                                  ? Icons.pending_actions
                                                  : Icons.check_circle_outline,
                                              size: 26,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              fit: FlexFit.tight,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      snapshot.data.docs[index]
                                                          ['service'],
                                                      style: TextStyle(
                                                          fontFamily: 'sf',
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      snapshot.data.docs[index]
                                                          ['serviceDesc'],
                                                      style: TextStyle(
                                                          fontFamily: 'sf',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w100),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        _taskPopup(
                                            topicText: snapshot.data.docs[index]
                                                ['service'],
                                            textDesc: snapshot.data.docs[index]
                                                ['serviceDesc'],
                                            docId: snapshot.data.docs[index].id,
                                            vehicleModel: widget.model);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.purple),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(40, 15, 40, 15),
          child: Card(
            //* Topic card ----------------------------------------------------------------------
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            color: Colors.purple,
            elevation: 16,
            child: Container(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.library_add_check_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tasks',
                        style: TextStyle(
                            fontFamily: 'sf',
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'These are the recommondations\n for you from Gadget Market',
                        style: TextStyle(
                            fontFamily: 'sf',
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _taskPopup({topicText, textDesc, docId, vehicleModel}) {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 10.0, left: 15, right: 15),
                        child: Text(
                            //* Topic ----------------------------------------------------------------------------------------
                            topicText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'sf',
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: 15.0, left: 15, right: 15),
                      child: Text(
                          //* Description ----------------------------------------------------------------------------------------
                          textDesc,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'sf', fontSize: 18)),
                    ),
                    Divider(
                      height: 2.0,
                    ),
                    InkWell(
                      //* Set Pending Button ---------------------------------------------------------------------------------------
                      child: Container(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                        ),
                        child: Text(
                          'More Details',
                          style: TextStyle(
                              fontFamily: 'sf',
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                TaskDetailsScreen(
                              taskTopic: topicText,
                              taskDesc: textDesc,
                              vehicleModel: vehicleModel,
                            ),
                            transitionDuration: Duration(seconds: 0),
                          ),
                        );
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    InkWell(
                      //* Set Pending Button ---------------------------------------------------------------------------------------
                      child: Container(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                        ),
                        child: Text(
                          'Set to Pending',
                          style: TextStyle(
                              fontFamily: 'sf',
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        FirebaseFirestore.instance
                            .collection('history')
                            .doc(auth.currentUser.uid)
                            .collection(widget.vehicleNumber)
                            .doc(docId)
                            .update({
                          'status': 'pending_actions',
                        });
                        Navigator.pop(context);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    InkWell(
                      //* Set Done Button ---------------------------------------------------------------------------------------
                      child: Container(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                        ),
                        child: Text(
                          'Set to Done',
                          style: TextStyle(
                              fontFamily: 'sf',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        FirebaseFirestore.instance
                            .collection('history')
                            .doc(auth.currentUser.uid)
                            .collection(widget.vehicleNumber)
                            .doc(docId)
                            .update({
                          'status': 'check_circle_outline',
                        });
                        Navigator.pop(context);
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
