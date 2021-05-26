import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MarketWebViewScreen extends StatefulWidget {
  final String link;
  MarketWebViewScreen({@required this.link});

  @override
  _MarketWebViewScreenState createState() => _MarketWebViewScreenState();
}

class _MarketWebViewScreenState extends State<MarketWebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
        child: WebView(
          initialUrl: widget.link,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
