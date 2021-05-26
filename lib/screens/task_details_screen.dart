import 'package:Gadget_Doctor_MobileApp/widgets/gadget_expert_card.dart';
import 'package:Gadget_Doctor_MobileApp/widgets/gadget_market_card.dart';
import 'package:Gadget_Doctor_MobileApp/widgets/scroll_glow_disabler.dart';
import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatefulWidget {
  final String taskTopic;
  final String taskDesc;
  final String vehicleModel;
  TaskDetailsScreen({
    @required this.taskTopic,
    @required this.taskDesc,
    @required this.vehicleModel,
  });

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 35,
                ),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                widget.taskTopic,
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
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: Text(
                                widget.taskDesc,
                                style: TextStyle(
                                    fontFamily: 'sf',
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            GadgetExpertCard(
                              taskTopic: widget.taskTopic,
                              vehicleModel: widget.vehicleModel,
                            ),
                            GadgetMarketCard()
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
