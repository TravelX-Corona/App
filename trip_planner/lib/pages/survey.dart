import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_planner/code/data.dart';

class CoronaSurvey extends StatefulWidget {
  @override
  _CoronaSurveyState createState() => _CoronaSurveyState();
}

class _CoronaSurveyState extends State<CoronaSurvey> {

  bool maskLow = true;
  bool maskMed = false;
  bool maskHigh = false;

  bool sdYes = false;
  bool sdNo = false;

  final crowd = TextEditingController();

  final capacity = TextEditingController();

  final comments = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    crowd.dispose();
    capacity.dispose();
    comments.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(207, 92, 54, 1.0),
        title: Text(
          'Condition Survey'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Mask Rating: ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,0,5,0),
                      child: Column(
                        children: <Widget>[
                          Checkbox(
                            activeColor: Color.fromRGBO(207, 92, 54, 1.0),
                            value: maskLow,
                            onChanged: (bool val){
                              setState(() {
                                maskLow = val;
                                maskHigh = false;
                                maskMed = false;
                              });
                            },
                          ),
                          Text(
                              "None-Few"
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,0,5,0),
                      child: Column(
                        children: <Widget>[
                          Checkbox(
                            value: maskMed,
                            activeColor: Color.fromRGBO(207, 92, 54, 1.0),
                            onChanged: (bool val){
                              setState(() {
                                maskLow = false;
                                maskHigh = false;
                                maskMed = val;
                              });
                            },
                          ),
                          Text(
                              "Some-Half"
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,0,5,0),
                      child: Column(
                        children: <Widget>[
                          Checkbox(
                            value: maskHigh,
                            activeColor: Color.fromRGBO(207, 92, 54, 1.0),
                            onChanged: (bool val){
                              setState(() {
                                maskLow = false;
                                maskHigh = val;
                                maskMed = false;
                              });
                            },
                          ),
                          Text(
                              "Almost All"
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Divider(thickness: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Social Distancing: ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Checkbox(
                          value: sdNo,
                          activeColor: Color.fromRGBO(207, 92, 54, 1.0),
                          onChanged: (bool val){
                            setState(() {
                              sdNo = val;
                              sdYes = false;
                            });
                          },
                        ),
                        Text(
                            'No'
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Checkbox(
                          value: sdYes,
                          activeColor: Color.fromRGBO(207, 92, 54, 1.0),
                          onChanged: (bool val){
                            setState(() {
                              sdNo = false;
                              sdYes = val;
                            });
                          },
                        ),
                        Text(
                            'Yes'
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            Divider(thickness: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Approximate Crowd Size: ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  width: 150,
                  child: TextFormField(
                    cursorColor: Colors.black,
                    controller: crowd,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(207, 92, 54, 1.0))),
                      hintText: 'Enter a number'
                    ),
                  ),
                ),
              ],
            ),
            Divider(thickness: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Building Max Capacity: ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  width: 150,
                  child: TextFormField(
                    controller: capacity,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(207, 92, 54, 1.0))),
                        hintText: 'Enter a number'
                    ),
                  ),
                ),
              ],
            ),
            Divider(thickness: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Comments: ",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  width: 150,
                  height: 50,
                  child: TextFormField(
                    controller: comments,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.multiline,
                    maxLines: 20,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(207, 92, 54, 1.0))),
                        hintText: 'Type Review Here'
                    ),
                  ),
                ),
              ],
            ),
            Divider(thickness: 2,),
            SizedBox(height: 20,),
            Align(
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(20,10,20,10),
                onPressed: (){
                  dataMaker.sendData(maskLow, maskMed, maskHigh, sdNo, sdYes, crowd.text, capacity.text, comments.text);
                  Navigator.pop(context, (){setState(() {

                  });});
                  },
                color: Colors.grey,
                child: Container(
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                      color: Colors.black
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Image(image: NetworkImage('http://18.223.124.135:7000/logo.png'), height: 150,)
          ],
        ),
      ),
    );
  }
}
