import "RecordPage.dart";
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
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
        title: new Text("Welcome In SplashScreen Package"),
        automaticallyImplyLeading: false,
      ),
      body: new Center(
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
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            labelText: 'Device',
                            labelStyle: TextStyle(fontSize: 25, fontFamily: 'Lato'
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.edit),
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

      ),
    );
  }
}