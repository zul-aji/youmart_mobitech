// source: https://itnext.io/push-notifications-with-firebase-on-flutter-df68cc830c89

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants.dart';
import '../../../../notifier/notification.dart';

class NotificationTest extends StatefulWidget {

  @override
  State<NotificationTest> createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
  //Controllers
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';


  @override
  Widget build(BuildContext context) {

    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    _changeData(String msg) => setState(() => notificationData = msg);
    _changeBody(String msg) => setState(() => notificationBody = msg);
    _changeTitle(String msg) => setState(() => notificationTitle = msg);

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          backgroundColor: colorWhite,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: colorAccent),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: colorWhite,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        notificationTitle,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        notificationBody,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        notificationData,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 45),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
