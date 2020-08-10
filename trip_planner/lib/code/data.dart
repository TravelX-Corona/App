import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_animations/simple_animations.dart';
import 'package:trip_planner/pages/comment.dart';

class dataMaker{

  dataMaker(double lat, double lon, String place){
    this.lat = lat;
    this.lon = lon;
    id = place;
    latitude = lat.toString();
    longitude = lon.toString();
  }

  List<double> pop = [];
  Map<String,dynamic> comments_stuff;

  double lat, lon;

  String id;

  Widget safety;

  static String latitude, longitude;

  String test = "this";

  List<Weather> weather = new List<Weather>();

  String temp;
  String description;
  String weather_image;
  String sunrise;
  String sunset;

  String weekday;
  String openTime = "";

  int hourCurrent;

  Widget statViewer;

  static String url = 'http://18.223.124.135:7000/';

  Future getTimes() async{
    print("HEERREE");
    var now = DateTime.now();
    weekday = now.weekday.toString();
    final response = await http.get(url + "openhours/" + id + '/' + weekday);
    Map<String,dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {print(key + " --> " + value.toString());});
    openTime = data['text'];
    print("Completed Get");
    return true;
  }

  Future getData() async{
    var now = DateTime.now();
    hourCurrent = now.hour;
    weekday = now.weekday.toString();
    print(now);
    final response = await http.get(url + "info/" + lat.toString() + '/' + lon.toString());
    Map<String,dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {print(key + " --> " + value.toString());});
    weather_image  = data['currentVals'][2].toString();
    temp = data['currentVals'][0].toString() + "°";
    print(data['sixhrsprecip'][0].toString());
    for(int i = 0; i < 6; i++) {
      weather.add(Weather(
          data['sixhrstemps'][i].toString(), data['sixhrsprecip'][i].toString(),
          i, data['sixhrsicons'][i].toString()));
      print("Added");
    }
    print("OutOfLoop");
    return true;
  }

  List<Widget> weatherTree(){
    List<Widget> tempData = new List<Widget>();
    tempData.add(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            "Time: ",
          style: TextStyle(
            fontWeight: FontWeight.w900
          ),
        ),
        Text(
            "Temperature: ",
          style: TextStyle(
              fontWeight: FontWeight.w900
          ),
        ),
        Text(
            "Rain: ",
          style: TextStyle(
              fontWeight: FontWeight.w900
          ),
        ),
      ],
    ));
    for(int i = 0; i<6; i++){
      tempData.add(Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                convertHours(hourCurrent + i) + ":00"
            ),
            Text(
                (weather[i].temperature) + "°"
            ),
            Text(
                (double.parse(weather[i].precipitation)*100).floor().toString() + "%"
            ),
            Image(
              image: NetworkImage(weather[i].image),
              width: 40,
            )
          ],
        ),
      ));
    }
    return tempData;
  }
  
  String convertHours(int hour){
    if(hour > 12){
      return (hour - 12).toString();
    }
    return hour.toString();
  }

  Future getRisk(context, dataMaker maker) async{
    final response = await http.get(url + "scoredisplay/" + lat.toString() + "/" + lon.toString());
    Map<String,dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {print(key + " --> " + value.toString());});
    if(data['status'] == 'VERY LOW'){
      safety = Text("Risk Rating: " + data['status'], style: TextStyle(
                fontWeight: FontWeight.bold,
                  fontFamily: "Cabin",));
    }
    if(data['status'] == 'LOW'){
      safety = Container(height: 75,color: Colors.lightGreen, width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text("Risk Rating: "+ data['status'], style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ));
    }
    if(data['status'] == 'MEDIUM'){
      safety = Container(height: 75,color: Colors.yellow, width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text("Risk Rating: " + data['status'], style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ));
    }
    if(data['status'] == 'HIGH'){
      safety = Container(height: 75,color: Colors.orange, width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text("Risk Rating: " + data['status'], style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ));
    }
    if(data['status'] == 'VERY HIGH'){
      safety = Container(height: 75,color: Colors.red, width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text("Risk Rating: " + data['status'], style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ));
    }
    if(data['status'] == 'NO ENTRIES DETECTED'){
      safety = Container(height: 75,color: Colors.grey, width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text("Risk Rating: " + data['status'], style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
          ));
    }
    print(response.body);
    test = response.body;
    return true;
  }

  static void sendData(bool none, bool half, bool all, bool no, bool yes, String crowd, String capacity, String comments) async{
    String req = "riskscore/";
    req = req + capacity + "/";
    req = req + crowd + "/";
    if(none){
      req = req + "0/";
    }
    else if(half){
      req = req + "1/";
    }
    else if(all){
      req = req + "2/";
    }
    if(no){
      req = req + "False/";
    }
    if(yes){
      req = req + "True/";
    }
    req = req + latitude + "/";
    req = req + longitude + "/";
    req = req + comments;

    final response = await http.get(url + req);
  }

  List<Widget> getGraph(){
    List<Widget> tempData = new List<Widget>();
    for(int i = 0; i < 24; i++) {
      print(pop.length);
      if(i == 0){
        tempData.add(Bar(pop[i], "12"));
      }
      if(i > 0 && i < 13) {
        tempData.add(Bar(pop[i], i.toString()));
      }
      if(i>12){
        tempData.add(Bar(pop[i], (i-12).toString()));
      }
    }
    return tempData;
  }

  Future getGraphData() async{
    final response = await http.get(url + "histodata/" + id + "/" + weekday);
    Map<String,dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {print(key + " --> " + value.toString());});
    for(int i = 0; i < 24; i++){
      pop.add(data["histovals"][i]/100);
    }
    return true;
  }

  Future getComments() async{
    final response = await http.get(url + "calcdata/" + lat.toString() + "/" + lon.toString());
    Map<String,dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {print(key + " --> " + value.toString());});
    comments_stuff = data;
    return true;
  }

  List<Widget> buildComment(){
    List<Widget> dump = List<Widget>();
    dump.add(Padding(
      padding: const EdgeInsets.fromLTRB(0,20,0,20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Average Score: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              Text(
                comments_stuff['avgscore'].toString(),
                style: TextStyle(
                  fontSize: 20
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Reported by: ",
                style: TextStyle(
                    fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                  comments_stuff['scorefreq'].toString() + " users",
                style: TextStyle(
                  fontSize: 20
                ),
              )
            ],
          )
        ],
      ),
    ));
    for(int i = 0; i < comments_stuff['comments'].length; i++){
      dump.add(Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,10,20,10),
            child: Text(comments_stuff['comments'][i],
            style: TextStyle(fontSize: 20),),
          ),
        ],
      ));
    }
    return dump;
  }
  
}

class Weather{
  String temperature;
  String precipitation;
  int timer;
  String image;

  Weather(String temp, String precip, int time, String png){
    temperature = temp;
    precipitation = precip;
    timer = time;
    image = png;
  }
}

class Bar extends StatelessWidget {
  final double height;
  final String label;

  final int _baseDurationMs = 3000;
  final double _maxElementHeight = 150;

  Bar(this.height, this.label);

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      duration: Duration(milliseconds: (height * _baseDurationMs).round()),
      tween: Tween(begin: 0.0, end: height),
      builder: (context, animatedHeight) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(1,0,1,0),
          child: Container(
            width: 20,
            child: Column(
              children: <Widget>[
                Container(
                  height: (1 - animatedHeight) * _maxElementHeight,
                ),
                Container(
                  width: 10,
                  height: animatedHeight * _maxElementHeight,
                  color: Color.fromRGBO(207, 92, 54, 1.0),
                ),
                Text(label)
              ],
            ),
          ),
        );
      },
    );
  }
}