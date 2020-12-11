import 'package:flutter/material.dart';
import 'Server.dart';
class RecordPage extends StatefulWidget {
  RecordPage({Key key, this.title}) : super(key: key);

  // This widget is the record page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {

  Server server = Server();
  var dateList = [];
  var confidenceList = [];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    server.getTimestamps(widget.title).then((value) {setState(() {
      value.forEach((k, v) {
        var date = DateTime.fromMillisecondsSinceEpoch(int.parse(k) * 1000);
        print(date);
        dateList.add(date.toString().substring(0, 16));
        confidenceList.add(v.toString());
      });
    });}
  );
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: DecoratedBox(
      position: DecorationPosition.background,
      decoration: BoxDecoration(
      image: DecorationImage(
      image: AssetImage('asset/background.png'), fit: BoxFit.cover),
      ),
      child: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30.0),
            Expanded(flex:1,
              child: dateList.isNotEmpty
                  ? Text(
                'Last Bark Date/confidence ' +
                    dateList[dateList.length - 1] +
                    " / " +
                    confidenceList[confidenceList.length - 1],
                style: TextStyle(fontSize: 30,fontFamily: 'Lato',color: Colors.brown,backgroundColor: Colors.white70,),
                textAlign: TextAlign.center,
              )
                  : Text('No data')),

        Expanded(flex:4,
          child: ListView.builder(
            itemCount: dateList.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text(dateList[index]),
                    subtitle: Text(confidenceList[index]),

                  ),
                ),
              ]);
            }
          ),
        )],
        ),)
      ),
    );
  }
}