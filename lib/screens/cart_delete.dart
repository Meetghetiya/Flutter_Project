import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/model/Postmodel.dart';

class MyListItem extends StatefulWidget {
  final dynamic data;
  final int index;
  final String id;
  // List<cartapi> myDataList;

  MyListItem(this.data, this.index, this.id);

  @override
  _MyListItemState createState() => _MyListItemState();
}

class _MyListItemState extends State<MyListItem> {
  bool _isSelected = false;
  int _selectedIndex = -1;

  void _deleteItem(int index) {
    deletedata();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedIndex == widget.index) {
            _selectedIndex = -1;
          } else {
            _selectedIndex = widget.index;
          }
        });
      },
      onLongPress: () {
        setState(() {
          _selectedIndex = widget.index;
        });
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCartItem(widget.data),
            if (_selectedIndex == widget.index) ...[
              Container(
                padding: EdgeInsets.only(left: 10),
                child: ElevatedButton(
                  onPressed: () {
                    _deleteItem(widget.index);
                    refreshScreen();
                    setState(() {
                      _selectedIndex = -1;
                    });
                  },
                  child: Text(
                    'Delete',
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void refreshScreen() {
    setState(() {});
  }

  int _counter = 1;

  void _decrementCounter() async {
    try {
      final newCounter = _counter - 1;
      final newCounterstring = newCounter.toString();
      final response = await http.put(
          Uri.parse(
              'https://63f83cf26978b1f910558673.mockapi.io/post/${widget.id}'),
          body: {"counter": newCounterstring});

      if (response.statusCode == 200) {
        setState(() {
          _counter = newCounter;
        });
      } else {
        print('Error updating counter: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating counter: $error');
    }
  }

  void _incrementCounter() async {
    try {
      final newCounter = _counter + 1;
      final newCounterstring = newCounter.toString();
      final response = await http.put(
          Uri.parse(
              'https://63f83cf26978b1f910558673.mockapi.io/post/${widget.id}'),
          body: {"counter": newCounterstring});

      if (response.statusCode == 200) {
        setState(() {
          _counter = newCounter;
        });
      } else {
        print('Error updating counter: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating counter: $error');
    }
  }

  int number = 1;

  Future<void> deletedata() async {
    final result = await http.delete(Uri.parse(
        'https://63f83cf26978b1f910558673.mockapi.io/post/${widget.id}'));
    if (result.statusCode == 200) {
      setState(() {
        // widget.myDataList.removeAt(widget.index);
      });
    } else {}
  }

  _buildCartItem(data) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
      child: Container(
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 20.0,
              )
            ]),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  width: 100.0,
                  height: 94.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                    ),
                    color: Colors.amber,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Image(
                      height: 200.0,
                      width: 200.0,
                      image: NetworkImage(widget.data.avatar),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 140.0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.0, top: 15.0),
                        child: Text(
                          widget.data.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 140.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Text(
                                  widget.data.color,
                                  style: TextStyle(
                                      color: Colors.black26, fontSize: 13.0),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              width: 140.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Text(
                                  widget.data.name,
                                  style: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 12.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    if (_counter < 1) {
                                      _counter;
                                    } else {
                                      _incrementCounter();
                                    }
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.plus,
                                    color: Colors.white,
                                    size: 12.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "${_counter}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    if (_counter <= 1) {
                                      _counter;
                                    } else {
                                      _decrementCounter();
                                    }
                                  },
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Colors.white,
                                    size: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: 140.0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Text(
                          '\$' + widget.data.price,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
