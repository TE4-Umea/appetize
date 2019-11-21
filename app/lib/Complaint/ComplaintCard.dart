import 'package:flutter/material.dart';
import 'package:Appetize/globals.dart' as globals;

class ComplaintCard extends StatefulWidget {
  String complaint;
  int index;

  ComplaintCard(this.complaint, this.index);

  @override
  _ComplaintCardState createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: widget.complaint);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                child: Column(
                  children: <Widget>[
                    Padding(
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Kommentar',
                            textScaleFactor: 1,
                            style: new TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 35.0,
                            width: 35.0,
                            child: IconButton(
                              padding: new EdgeInsets.all(0.0),
                              color: Colors.white,
                              icon: new Icon(Icons.clear, size: 20),
                              onPressed: () {
                                print(widget.complaint);
                                // FIXME:?????????
                                //????????????????????
                                //?????????????????????????
                                globals.complaints.value
                                    .remove(widget.complaint);
                                globals.complaints.notifyListeners();
                              },
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: _controller,
                        autofocus: widget.complaint.length == 0,
                        onChanged: (value) {
                          globals.complaints.value[widget.index] = value;
                          print(globals.complaints.value.toString());
                        },
                        style: new TextStyle(
                            color: globals
                                .restaurants[globals.restaurant.value].color,
                            fontSize: 16,
                            height: 0.75),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: globals.restaurants[globals.restaurant.value].color,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.2),
                  blurRadius: 8,
                  spreadRadius: 2)
            ]),
      ),
      padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
    );
  }
}
