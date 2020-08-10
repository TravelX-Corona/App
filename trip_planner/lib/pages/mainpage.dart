import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:trip_planner/code/data.dart';
import 'package:trip_planner/pages/aboutus.dart';
import 'package:trip_planner/pages/survey.dart';

import 'comment.dart';
import 'login.dart';

class LandingPage extends StatefulWidget {

  final logoutAction;
  final String name;
  final String picture;

  LandingPage(this.logoutAction, this.name, this.picture);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: 'AIzaSyBvOur9iaRBPKa7aJWgHZObOIwr1b1O7PM');
  static Positioner pointer = new Positioner();

  bool built = false;
  Map<String, Marker> _markers;
  //final marker = Marker(position: LatLng(pointer.latitude, pointer.longitude), markerId: MarkerId('Business'));


  void _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 150,
              color: Color.fromRGBO(207, 92, 54, 1.0),
              child: DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "User:",
                          style: TextStyle(
                            fontFamily: 'Cabin',
                            fontSize: 20,
                            letterSpacing: 1
                          )
                        ),
                        SizedBox(height: 10,),
                        Text(
                          widget.name,
                            style: TextStyle(
                                fontFamily: 'Cabin',
                                fontSize: 15
                            )
                        ),
                      ],
                    ),
                    CircleAvatar(backgroundImage: NetworkImage(widget.picture), radius: 25,)
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: (){
                setState(() {
                  built = false;
                });
              },
            ),
            ListTile(
              title: Text("About Us"),
              leading: Icon(Icons.speaker_notes),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs(widget.logoutAction,widget.name, widget.picture)));},
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.lock_open),
              onTap: (){
                widget.logoutAction();
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(207, 92, 54, 1.0),
        title: Text('TravelX'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              setState(() {
                built = false;
              });
              Prediction p = await PlacesAutocomplete.show(
                mode: Mode.overlay,
                context: context,
                apiKey: 'AIzaSyBvOur9iaRBPKa7aJWgHZObOIwr1b1O7PM'
              );
              print(p.placeId);
              print(p.description);
              pointer.add = p.description;
              pointer.id = p.placeId;
              PlacesDetailsResponse detail =
              await _places.getDetailsByPlaceId(p.placeId);
              pointer.latitude = detail.result.geometry.location.lat;
              pointer.longitude = detail.result.geometry.location.lng;
              final GoogleMapController controller = await _controller.future;
              setState(() {
                built = true;
                controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(detail.result.geometry.location.lat, detail.result.geometry.location.lng),
                  zoom: 10.0,
                )));
                _markers = {"Business" : Marker(position: LatLng(pointer.latitude, pointer.longitude), markerId: MarkerId('Business'))};
              });
            },
          )
        ],
      ),
      body: getBody(built, pointer, _onMapCreated, context, _markers),
      floatingActionButton: floatingAction(built, context, pointer),
    );
  }
}

Widget floatingAction(bool build, context, Positioner maker){
  if(build){
    return FloatingActionButton.extended(
      splashColor: Color.fromRGBO(239, 200, 139, 1.0),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CoronaSurvey()));
      },
      backgroundColor: Color.fromRGBO(207, 92, 54, 1.0),
      label: Text(
          "Submit Report"
      ),
      icon: Icon(Icons.chat_bubble_outline),
    );
  }
  else{
    return null;
  }
}

Widget getBody(bool build, Positioner pointer, Function _onMapCreated, context, Map<String, Marker> markers){
  dataMaker maker = new dataMaker(pointer.latitude, pointer.longitude, pointer.id);
  final ScrollController scroller = ScrollController();
  final ScrollController scroller_graph = ScrollController();
  if (build){
    return Container(
      color: Color.fromRGBO(239, 200, 139, 1.0),
      child: ListView(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      myLocationButtonEnabled: true,
                      markers: markers.values.toSet(),
                      initialCameraPosition: CameraPosition(
                        target: LatLng(pointer.latitude, pointer.longitude),
                        zoom: 15.0,
                      ),
                    ),
        ),
        FutureBuilder(
          future: maker.getTimes(),
          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Text("loading");
              default:
                return Container(
                  color: Color.fromRGBO(239, 200, 139, 1.0),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          pointer.add,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Cabin',
                            fontSize: 20,
                            color: Colors.grey[900],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          maker.openTime,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Cabin',
                            fontSize: 20,
                            color: Colors.grey[900],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
            }
          },
        ),
        Container(
          color: Colors.black,
          height: 2,
        ),
        SizedBox(
          height: 120,
          child: FutureBuilder(
            future: maker.getData(),
            builder: (context, snapshot){
              switch (snapshot.connectionState){
                case ConnectionState.waiting:
                  return Center(
                    child: SpinKitWave(
                      color: Color.fromRGBO(239, 200, 139, 1.0),
                      type: SpinKitWaveType.start,
                    ),
                  );
                default:
                  if(snapshot.hasError){
                    return Center(child:Text("Error Loading Weather"));
                  }
                  return Container(
                    color: Color.fromRGBO(239, 200, 139, 1.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: NetworkImage(maker.weather_image),
                          ),
                          SizedBox(width: 20,),
                          Text(
                            maker.temp,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900]
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: Scrollbar(
                              isAlwaysShown: true,
                              controller: scroller,
                              child: ListView(
                                  shrinkWrap: true,
                                  controller: scroller,
                                  scrollDirection: Axis.horizontal,
                                  children: maker.weatherTree()
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
              }
            },
          ),
        ),
        Container(height: 2, color: Colors.black,),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: maker.getRisk(context, maker),
                builder: (context, snapshot){
                  switch (snapshot.connectionState){
                    case ConnectionState.waiting:
                      return Container(height: 75,child:Center(child:Text("Loading")));
                    default:
                      if(snapshot.hasError){
                        return Container(height: 75,child:Center(child:Text("Error Loading Safety")));
                      }
                      return Container(
                                height: 75,color: Colors.green, width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: InkWell(
                                      onTap: (){print("PRESSED");
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CommentReader(maker)));},
                                      child: maker.safety,
                                      )
                                )
                      );
                  }
                },
              )
            ],
          ),
        ),
        Container(height: 2, color: Colors.black,),
        Container(
          color: Color.fromRGBO(239, 200, 139, 1.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,15,0,0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "Crowd Graph:",
                    style: TextStyle(
                      fontFamily: "Cabin",
                      fontSize: 25,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,20,0,0),
                    child: FutureBuilder(
                      future: maker.getGraphData(),
                      builder: (context, snapshot){
                        switch (snapshot.connectionState){
                          case ConnectionState.waiting:
                            return Container(
                              height: 200,
                                child: SpinKitWave(
                                  color: Color.fromRGBO(239, 200, 139, 1.0),
                                  type: SpinKitWaveType.start,
                                ),
                            );
                          default:
                            if(snapshot.hasError){
                              return Container(height: 200,child:Center(child:Text("Error Loading Crowd")));
                            }
                            return Container(
                              height: 200,
                              child: Scrollbar(
                                isAlwaysShown: true,
                                controller: scroller_graph,
                                child: ListView(
                                  controller: scroller_graph,
                                  scrollDirection: Axis.horizontal,
                                    children: maker.getGraph()
                                ),
                              ),
                            );
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    )
    );
  }
  else{
    return FutureBuilder(
        future: pointer.updatePosition(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return (
                  Center(
                    child: Container(
                      height: 50,
                      child: SpinKitWave(
                        color: Color.fromRGBO(239, 200, 139, 1.0),
                        type: SpinKitWaveType.start,
                      ),
                    )
                  )
              );
            default:
              return GoogleMap(
                onMapCreated: _onMapCreated,
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(pointer.latitude, pointer.longitude),
                  zoom: 11.0,
                ),
              );
          }
        }
    );
  }
}

class Positioner{
  double latitude = 0;
  double longitude = 0;
  String add = "";
  String id = "";

  Future updatePosition() async{
    var position =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
    print(latitude);
    print(longitude);
    return true;
  }

}
