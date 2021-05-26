import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskCountCard extends StatefulWidget {
  final Color color;
  final String topicText;
  final String bottomText;
  final String vehicleNo;
  final IconData mainIcon;
  final IconData bottomIcon;
  TaskCountCard(
      {@required this.topicText,
      @required this.bottomText,
      @required this.vehicleNo,
      @required this.color,
      @required this.mainIcon,
      @required this.bottomIcon});

  @override
  _TaskCountCardState createState() => _TaskCountCardState();
}

class _TaskCountCardState extends State<TaskCountCard> {
  FirebaseAuth auth = FirebaseAuth.instance;

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
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(top: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.topicText,
                        style: TextStyle(
                            fontFamily: 'sf',
                            fontSize: 20,
                            color: Colors.black54),
                      ),
                      SizedBox(height: 4),
                      StreamBuilder(
                        //* Get data from firestore -------------------------------------------------------------------------
                        stream: (widget.topicText == 'Warnings')
                            ? FirebaseFirestore.instance
                                .collection('history')
                                .doc(auth.currentUser.uid)
                                .collection(widget.vehicleNo)
                                .where('status', isEqualTo: 'pending_actions')
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection('history')
                                .doc(auth.currentUser.uid)
                                .collection(widget.vehicleNo)
                                .where('status',
                                    isEqualTo: 'check_circle_outline')
                                .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text(
                              'Loading',
                              style: TextStyle(
                                  fontFamily: 'sf',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            );
                          }
                          return Text(
                            //* Show count -----------------------------------------------------------------------------
                            snapshot.data.docs.length.toString(),
                            style: TextStyle(
                                fontFamily: 'sf',
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          );
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
                  child: Row(
                    children: [
                      Icon(
                        widget.bottomIcon,
                        color: Colors.black54,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.bottomText,
                        style: TextStyle(
                            fontFamily: 'sf',
                            fontSize: 16,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 80,
          height: 80,
          margin: EdgeInsets.fromLTRB(40, 15, 20, 8),
          child: Card(
            //* Icon card ----------------------------------------------------------------------
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            color: widget.color,
            elevation: 16,
            child: Container(
              alignment: Alignment.center,
              child: Icon(
                widget.mainIcon,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
