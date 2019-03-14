import 'package:flutter/material.dart';
import '../util/utils.dart' as util;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {

  void showStuff() async{
     Map data = await getWeather(util.appId, util.defaultCity);

     print(data.toString());
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Klimatic'),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              color: Colors.white,
              onPressed: showStuff)
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              "images/umbrella.png",
              fit: BoxFit.fill,
              height: 1200.0,
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: new Text(
              'Spokane',
              style: cityStyle(),
            ),
          ),
          new Container(
            alignment: Alignment.center,
            child: new Image.asset("images/light_rain.png"),
          ),

          //container which will have our weather data
          new Container(
            margin: const EdgeInsets.fromLTRB(30.0, 350.0, 0.0, 0.0),
              child: new Text('67.8F',
                style: tempStyle(),
              ))
        ],
      ),
    );
  }

  Future <Map> getWeather(String appId,String city) async{
    String apiUrl="http://api.openweathermap.org/data/2.5/weather?q=$city,pt&appid="
        "${util.appId}&units=metric";

    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);

  }


}

TextStyle cityStyle() {
  return new TextStyle(
    color: Colors.white,
    fontSize: 22.9,
    fontStyle: FontStyle.italic,
  );
}

TextStyle tempStyle() {
  return new TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 49.9,
  );
}
