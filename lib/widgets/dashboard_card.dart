import 'package:flutter/material.dart';

class DashboardCard extends StatefulWidget {
  final Color color;
  final String topicText;
  final String detailText;
  final String bottomText;
  final IconData mainIcon;
  final IconData bottomIcon;
  final String buttonText;
  final Function editFunction;
  DashboardCard(
      {@required this.topicText,
      @required this.detailText,
      @required this.bottomText,
      @required this.buttonText,
      @required this.color,
      @required this.mainIcon,
      @required this.bottomIcon,
      @required this.editFunction});

  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
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
                      Text(
                        widget.detailText,
                        style: TextStyle(
                            fontFamily: 'sf',
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
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
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 8),
                  child: Card(
                    //* Edit Button ----------------------------------------------------------------------
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    color: widget.color,
                    elevation: 0,
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.buttonText,
                              style: TextStyle(
                                  fontFamily: 'sf',
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      onTap: widget.editFunction,
                    ),
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
