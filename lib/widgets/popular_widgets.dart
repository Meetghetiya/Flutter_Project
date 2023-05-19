import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furniture_app_ui/data/data.dart';
import 'package:furniture_app_ui/models/chair.dart';
import 'package:http/http.dart' as http;
import 'package:furniture_app_ui/screens/details_screen.dart';

import '../models/model/Apimodel.dart';

class PopularProducts extends StatefulWidget {
  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  _buildPopularProducts(
      BuildContext context, int index, List<Apimodel> postlist) {
    Chair chair = popular[index];
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
          children: [
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 20.0,
                    )
                  ]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  width: 190.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      color: chair.backgorundColor),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Image(
                      height: 200.0,
                      width: 200.0,
                      image: NetworkImage(postlist[index].avatar),
                    ),
                  ),
                ),
                Container(
                  width: 200.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      postlist[index].name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  width: 200.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          postlist[index].name,
                          style:
                              TextStyle(fontSize: 14.0, color: Colors.black26),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          "\$ ${postlist[index].price}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 200.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      postlist[index].color,
                      style: TextStyle(color: Colors.black26, fontSize: 12.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  width: 200.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text("${postlist[index].rating.toString()}"),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              final id = postlist[index].id;
                              final idint = int.parse(id);
                              if (!_clickedIds.contains(idint)) {
                                _clickedIds.add(idint);
                                _postData(index);
                              }
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
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

  Set<int> _clickedIds = {};

  Future<void> _postData(index) async {
    // final idstring = id.toString();

    final response = await http.post(
        Uri.parse('https://63f83cf26978b1f910558673.mockapi.io/post'),
        body: {
          "id": postlist[index].id,
          "name": postlist[index].name,
          "avatar": postlist[index].avatar,
          "material": postlist[index].material,
          "rating": postlist[index].rating,
          "price": postlist[index].price.toString(),
          "color": postlist[index].color,
          "Details": postlist[index].details,
          "counter": "1"
        });

    if (response.statusCode == 200) {
      print('Data posted successfully');
    } else {
      throw Exception('Failed to post data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.0,
      child: FutureBuilder<List<Apimodel>>(
          future: getpostapi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: postlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildPopularProducts(context, index, postlist);
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
