import 'package:Gadget_Doctor_MobileApp/screens/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:Gadget_Doctor_MobileApp/widgets/scroll_glow_disabler.dart';
import 'package:Gadget_Doctor_MobileApp/screens/add_vehicle_screen.dart';

class SelectVehicleScreen extends StatefulWidget {
  @override
  _SelectVehicleScreenState createState() => _SelectVehicleScreenState();
}

class _SelectVehicleScreenState extends State<SelectVehicleScreen> {
  Future getVehicles() async {
    //* Get vehicle documents
    FirebaseAuth auth = FirebaseAuth.instance;
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("users")
        .doc(auth.currentUser.uid)
        .collection("Vehicles")
        .get();

    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        //* Background Image
        padding: EdgeInsets.fromLTRB(15, 35, 15, 35),
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
                  //* Select Vehicle Main Card ------------------------------------------------------------------------------------------------
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  color: Colors.black54,
                  elevation: 0,
                  child: ScrollGlowDisabler(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Select Your Vehicle',
                              style: TextStyle(
                                  fontFamily: 'sf',
                                  fontSize: 22,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Container(
                              //* Added Vehicles ----------------------------------------------------------------------------------
                              child: FutureBuilder(
                                future: getVehicles(),
                                builder: (_, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      width: double.infinity,
                                      padding:
                                          EdgeInsets.fromLTRB(20, 8, 20, 8),
                                      child: Card(
                                        //* Loading Card ----------------------------------------------------------------------
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                        color: Color(0xff21B5BD),
                                        elevation: 0,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: Text(
                                            'Loading...',
                                            style: TextStyle(
                                                fontFamily: 'sf',
                                                fontSize: 22,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (_, index) {
                                        return Container(
                                          width: double.infinity,
                                          padding:
                                              EdgeInsets.fromLTRB(20, 8, 20, 8),
                                          child: Card(
                                            //* Vehicle Card ----------------------------------------------------------------------
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                            ),
                                            color: Color(0xff21B5BD),
                                            elevation: 0,
                                            child: InkWell(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    top: 20, bottom: 20),
                                                child: Text(
                                                  snapshot.data[index]
                                                          .data()["Brand"] +
                                                      ' ' +
                                                      snapshot.data[index]
                                                          .data()["Model"] +
                                                      ' : ' +
                                                      snapshot.data[index]
                                                          .data()["Vehicle"],
                                                  style: TextStyle(
                                                      fontFamily: 'sf',
                                                      fontSize: 22,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              onTap: () {
                                                print(snapshot.data[index].id);
                                                Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation1,
                                                            animation2) =>
                                                        DashboardScreen(
                                                      vehicleID: snapshot
                                                          .data[index].id,
                                                    ),
                                                    transitionDuration:
                                                        Duration(seconds: 0),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                            Container(
                              //* Add new vehicle button ----------------------------------------------------------------------
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                color: Color(0xff47a44b),
                                elevation: 0,
                                child: InkWell(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle_outline_sharp,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Add New Vehicle',
                                          style: TextStyle(
                                              fontFamily: 'sf',
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder:
                                            (context, animation1, animation2) =>
                                                AddVehicleScreen(),
                                        transitionDuration:
                                            Duration(seconds: 0),
                                      ),
                                    );
                                  },
                                ),
                              ),
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
          ],
        ),
      ),
    );
  }
}
