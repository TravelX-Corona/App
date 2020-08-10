import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final loginAction;
  final String loginError;

  const LoginPage(this.loginAction, this.loginError);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(207, 92, 54, 1.0),
        title: Text("TravelX"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: NetworkImage("http://18.223.124.135:7000/logo.png"),width: MediaQuery.of(context).size.width*0.5,),
            SizedBox(height: 25,),
            Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: RaisedButton(
                color: Colors.blue[400],
                onPressed: () {
                  // ignore: unnecessary_statements
                  widget.loginAction();
                },
                child: Text('Login'),
              ),
            ),
            Text(widget.loginError ?? ''),
          ],
        ),
      )
    );
  }
}

class Base extends StatefulWidget {
  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
