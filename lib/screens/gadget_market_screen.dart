import 'package:Gadget_Doctor_MobileApp/screens/dashboard_screen.dart';
import 'package:Gadget_Doctor_MobileApp/screens/gadget_community_screen.dart';
import 'package:Gadget_Doctor_MobileApp/screens/gadget_expert_screen.dart';
import 'package:Gadget_Doctor_MobileApp/screens/market_webview_screen.dart';
import 'package:Gadget_Doctor_MobileApp/services/auth_service.dart';
import 'package:Gadget_Doctor_MobileApp/widgets/scroll_glow_disabler.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart';

class GadgetMarketScreen extends StatefulWidget {
  final String vehicleID;
  GadgetMarketScreen({@required this.vehicleID});
  @override
  _GadgetMarketScreenState createState() => _GadgetMarketScreenState();
}

class _GadgetMarketScreenState extends State<GadgetMarketScreen> {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

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
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          DashboardScreen(vehicleID: widget.vehicleID),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                },
              ),
              ListTile(
                tileColor: Color(0xff8E45AE),
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
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
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
            Container(
              padding: EdgeInsets.fromLTRB(15, 35, 15, 0),
              child: Row(children: [
                //* Header ------------------------------------------------------------------------------------------
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
                  'Gadget Market',
                  style: TextStyle(
                      fontFamily: 'sf',
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ]),
            ),
            Flexible(
              //* Webview --------------------------------------------------------------------------------------
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: WebView(
                  initialUrl: 'https://market.gadgetdoc.tech/',
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
