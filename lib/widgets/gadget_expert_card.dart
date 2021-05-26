import 'package:Gadget_Doctor_MobileApp/screens/market_webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

Future<List<Data>> fetchData() async {
  final response = await http.get(
      'https://expert.gadgetdoc.tech/ghost/api/v3/content/posts/?key=393518c903a40dad5503c49e49&include=authors,tags');
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['posts'];
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  final String name;
  final String author;
  final List tags;
  final String url;

  Data({this.name, this.author, this.tags, this.url});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        name: json['title'],
        author: json['authors'][0]['name'].toString(),
        tags: json['tags'],
        url: json['url']);
  }
}

class GadgetExpertCard extends StatefulWidget {
  final String taskTopic;
  final String vehicleModel;
  GadgetExpertCard({
    @required this.taskTopic,
    @required this.vehicleModel,
  });
  @override
  _GadgetExpertCardState createState() => _GadgetExpertCardState();
}

class _GadgetExpertCardState extends State<GadgetExpertCard> {
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
                              List tags = [];
                              for (int count = 0;
                                  count < data[index].tags.length;
                                  count++) {
                                tags.add(data[index].tags[count]['name']);
                              }
                              print(tags);
                              return (tags.contains(widget.taskTopic) ||
                                      tags.contains(widget.vehicleModel))
                                  ? Container(
                                      padding:
                                          EdgeInsets.fromLTRB(12, 5, 12, 5),
                                      child: Card(
                                        //* White Product Card ----------------------------------------------------------------------
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                        color: Colors.grey[300],
                                        elevation: 0,
                                        child: InkWell(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                12, 8, 12, 8),
                                            child: Row(
                                              children: [
                                                Text(
                                                  (index + 1).toString(),
                                                  style: TextStyle(
                                                      fontFamily: 'sf',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          data[index].name,
                                                          style: TextStyle(
                                                              fontFamily: 'sf',
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        data[index].author,
                                                        style: TextStyle(
                                                            fontFamily: 'sf',
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () async {
                                            await canLaunch(data[index].url)
                                                ? await launch(data[index].url)
                                                : throw 'Could not launch ${data[index].url}';
                                          },
                                        ),
                                      ),
                                    )
                                  : Container();
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
            color: Colors.blue,
            elevation: 16,
            child: Container(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.construction_sharp,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gadget Expert',
                        style: TextStyle(
                            fontFamily: 'sf',
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Theese are the expert\'s articles\nwe are recommending for you.',
                        style: TextStyle(
                          fontFamily: 'sf',
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
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
