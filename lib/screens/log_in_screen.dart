import 'package:flutter/material.dart';

import 'package:Gadget_Doctor_MobileApp/services/auth_service.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    error = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        child: Card(
                          //* Log in Card ------------------------------------------------------------------------------------------------
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          color: Colors.black54,
                          elevation: 0,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Log In',
                                style: TextStyle(
                                    fontFamily: 'sf',
                                    fontSize: 22,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 5),
                              Image.asset('lib/assets/logo.png'),
                              Container(
                                //* Login with google Button ----------------------------------------------------------------------------------
                                alignment: Alignment.bottomCenter,
                                margin: EdgeInsets.fromLTRB(30, 0, 30, 8),
                                child: RaisedButton(
                                  child: Container(
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'lib/assets/google-logo.png',
                                          width: 24,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Log in with Google',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'sf',
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                          //width: double.infinity,
                                        ),
                                      ],
                                    ),
                                  ),
                                  elevation: 4,
                                  // highlightColor: SharedData.buttonHighlightColor,
                                  color: Colors.white,
                                  padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                  ),
                                  onPressed: () {
                                    AuthService().signInWithGoogle();
                                  },
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
                  ],
                ),
              ),
            ],
          )),
    );
    ;
  }
}
