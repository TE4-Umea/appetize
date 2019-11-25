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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                child: Row(
                  children: <Widget>[
                    Padding(
                      child: IconButton(
                        padding: new EdgeInsets.all(5),
                        color: Colors.red,
                        icon: new Icon(
                          Icons.clear,
                          size: 25,
                        ),
                        onPressed: () {
                          // Delete from array
                          globals.complaints.value.removeAt(widget.index);
                          globals.complaints.notifyListeners();
                        },
                      ),
                      padding: EdgeInsets.only(right: 5, top: 9),
                    ),
                    Padding(
                      child: Text(
                        /* controller: _controller, */
                        widget.complaint,
                        style: new TextStyle(
                            color: Colors.black, fontSize: 18, height: .5),
                      ),
                      padding: EdgeInsets.only(top: 15),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 10,
                  spreadRadius: 1)
            ]),
      ),
      padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
    );
  }
}
