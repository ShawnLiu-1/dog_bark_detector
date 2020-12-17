import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Server {
  FirebaseFirestore _db;
  final databaseReference = FirebaseDatabase();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Server() {
    _init();
  }
  _init() async {
    await Firebase.initializeApp().then((value) {
      _db = FirebaseFirestore.instance;
    });
  }

  Future getTimestamps(String device) async {
    DataSnapshot ds = await databaseReference
        .reference()
        .child("device/" + device + "/timestamp")
        .once();
    print('********getting timestamps: ' + ds.value.toString());
    return ds.value;
  }

  Future<String> saveDeviceToken() async {
    await Future.delayed(Duration(seconds: 2));
    String fcmToken = await _firebaseMessaging.getToken();

    if (fcmToken != null) {
      var tokenRef =
          _db.collection('tokens').doc(fcmToken);
      await tokenRef.set({
        'token': fcmToken,
        'createAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem
      });
    }
  }
}
