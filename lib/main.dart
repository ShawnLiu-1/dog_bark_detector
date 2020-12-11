import "RecordPage.dart";
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var _message = '';
  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();
  _register();}

  void getMessage(){
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          setState(() => _message = message["notification"]["title"]);
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["title"]);
    });
  }
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new AfterSplash(),
      title: new Text('Welcome In SplashScreen',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),
      ),
      image: new Image.asset('asset/Shiba_Smile.png'),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red,
    );
  }
}

class AfterSplash extends StatelessWidget{
  var deviceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Dog Bark Detector"),
          automaticallyImplyLeading: false,
        ),
        body: DecoratedBox(
          position: DecorationPosition.background,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/background.png'), fit: BoxFit.cover),
          ),
          child: new Center(
              child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding (
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Row(
                          children: [
                            Expanded(flex:3,
                              child: TextField(

                                obscureText: false,
                                //style: ,
                                controller: deviceController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone_android),
                                  border: new OutlineInputBorder(borderSide: BorderSide(color: Colors.brown),
                                    borderRadius: new BorderRadius.circular(30.0),
                                  ),

                                  labelText: 'Device',
                                  labelStyle: TextStyle(fontSize: 25, fontFamily: 'Lato', color: Colors.brown,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.forward),
                                onPressed: () {
                                  print(deviceController.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RecordPage(
                                          title: deviceController.text,)),
                                  );

                                },
                              ),
                            )],
                        )
                    ),
                    SizedBox(height: 25.0),
                  ])

          ),)
    );
  }
}