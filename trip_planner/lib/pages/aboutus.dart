import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'mainpage.dart';

class AboutUs extends StatelessWidget {
  final logoutAction;
  final String name;
  final String picture;

  AboutUs(this.logoutAction, this.name, this.picture);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(207, 92, 54, 1.0),
        title: Text(
          'About Us'
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              Image(
                height: 250,
                image: NetworkImage("http://18.223.124.135:7000/logo.png"),
              ),
              SizedBox(height: 50,),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(text:"This application is intended to alleviate the stress of the COVID-19 experience. Fear of exposure during routine shopping trips or family outings is a serious concern for many families. In order to allow families to make more informed decisions about these trips, the developers have developed an algorithm based on published data which provides a metric for assessing risk. "),
                    ]
                ),
              ),
              Container(height: 20,),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "Although it is by no means definitive, it can help to quantify the degree of risk individuals will be taking on in the hopes of reducing anxiety and encouraging better choices. With the additional information regarding crowd densities and weather, families and individuals can plan their trips to minimize potential exposures and minimize time spent waiting in line or looking for out-of-stock items."),
                    ]
                ),
              ),
              Divider(),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "How Risk is Evaluated:"),
                    ]
                ),
              ),
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "Using studies published in the Lancet, the probabilities of COVID transmission have been quantified. These are best expressed in terms of face coverings and social distancing, which are factored into a score that also accounts for the ratio of actual density with expected capacity. From there, risk is placed into one of five categories:"),
                    ]
                ),
              ),
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "VERY LOW: You are safe, but make sure to wear a face covering and maintain appropriate distance."),
                    ]
                ),
              ),
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "LOW: You are safe, but make sure to wear a face covering and maintain appropriate distance."),
                    ]
                ),
              ),
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "MEDIUM: With appropriate face covering and social distance, you should be safe."),
                    ]
                ),
              ),
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "HIGH: This location may be unsafe - consider returning at another time."),
                    ]
                ),
              ),
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "VERY HIGH: This location is not safe or does not comply with suggested guidelines."),
                    ]
                ),
              ),
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "This application was developed by Rohan Harish and Varun Pai. Thank you to all of the healthcare workers, scientists and public health advocates, and essential personnel working tirelessly to ensure our nation's resilience in this trying time."),
                    ]
                ),
              ),
              SizedBox(height: 25,),
            ],
          )
        ),
      )
    );
  }
}
