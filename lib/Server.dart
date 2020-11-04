import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class Server{

  final databaseReference = FirebaseDatabase.instance.reference();

  Future getTimestamps(String device) async {

    DataSnapshot ds = await databaseReference.child(
        "device/"+ device+"/timestamp").once();
    print('********getting timestamps: ' + ds.value.toString());
    return ds.value;
  }

}