import 'package:Gadget_Doctor_MobileApp/screens/market_webview_screen.dart';
import 'package:flutter/material.dart';
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

class GadgetMarketCard extends StatefulWidget {
  @override
  _GadgetMarketCardState createState() => _GadgetMarketCardState();
}

class _GadgetMarketCardState extends State<GadgetMarketCard> {
  Future<List<Data>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
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
                    child: FutureBuilder<List<Data>>(
                      future: futureData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Data> data = snapshot.data;
                          return ListView.builder(
                            padding: EdgeInsets.only(top: 8),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                                child: Card(
                                  //* White Product Card ----------------------------------------------------------------------
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
                                        children: [
                                          Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                                fontFamily: 'sf',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    data[index].name,
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
                                                Text(
                                                  'LKR ' +
                                                      (data[index]
                                                              .price
                                                              .toString())
                                                          .substring(
                                                              0,
                                                              (data[index]
                                                                          .price
                                                                          .toString())
                                                                      .length -
                                                                  2) +
                                                      '.' +
                                                      (data[index]
                                                              .price
                                                              .toString())
                                                          .substring((data[
                                                                          index]
                                                                      .price
                                                                      .toString())
                                                                  .length -
                                                              2),
                                                  style: TextStyle(
                                                      fontFamily: 'sf',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      print(data[index].link);
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                                  animation2) =>
                                              MarketWebViewScreen(
                                                  link: data[index].link),
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
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.orange),
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
            color: Colors.green,
            elevation: 16,
            child: Container(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gadget Market',
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
}
