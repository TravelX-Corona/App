import 'package:flutter/material.dart';
import 'package:trip_planner/code/data.dart';

class CommentReader extends StatelessWidget {

  dataMaker maker;
  CommentReader(this.maker);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(207, 92, 54, 1.0),
        title: Text('Reviews'),
      ),
      body: FutureBuilder(
        future: maker.getComments(),
        builder: (context, snapshot){
          switch(snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text("Waiting");
            default:
              return Column(
                children: maker.buildComment(),
              );
          }
        },
      ),
    );
  }
}

