import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:furniture_app_ui/data/data.dart';
import 'package:furniture_app_ui/models/chair.dart';
import 'package:furniture_app_ui/screens/details_screen.dart';

import '../models/model/Apimodel.dart';

class RecentlyAdded extends StatelessWidget {
  _buildRecentProducts(BuildContext context, int index) {
    // Chair chair = recentlyAdded[index];
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailsScreen(index),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 25.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 250.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 20.0,
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    width: 100.0,
                    height: 94.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      color: Colors.amber,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Image(
                        height: 200.0,
                        width: 200.0,
                        image: NetworkImage(postlist[index].avatar),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 140.0,
                        child: Padding(
                          padding: EdgeInsets.only(left: 4.0, top: 15.0),
                          child: Text(
                            postlist[index].name,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container(
                        width: 140.0,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 4.0,
                          ),
                          child: Text(
                            postlist[index].color,
                            style: TextStyle(color: Colors.black26),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container(
                        width: 140.0,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 4.0,
                          ),
                          child: Text(
                            postlist[index].material,
                            style: TextStyle(color: Colors.black26),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Container(
                        width: 140.0,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 4.0,
                          ),
                          child: Text(
                            '\$' + "${postlist[index].price}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Apimodel> postlist = [];

  var client = http.Client();
  Future<List<Apimodel>> getpostapi() async {
    final response = await client
        .get(Uri.parse('https://63f83cf26978b1f910558673.mockapi.io/meet'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        postlist.add(Apimodel.fromJson(i));
      }
      return postlist;
    } else {
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: FutureBuilder<List<Apimodel>>(
          future: getpostapi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return _buildRecentProducts(context, index);
                },
                itemCount: postlist.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
