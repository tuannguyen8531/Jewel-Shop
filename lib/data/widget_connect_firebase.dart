import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyFirebaseConnection extends StatefulWidget {
  final String? errorMessage;
  final String? connectingMessage;
  final Widget Function(BuildContext context)? builder;
  const MyFirebaseConnection({
    Key? key,
    required this.errorMessage,
    required this.connectingMessage,
    required this.builder
  }) : super(key: key);

  @override
  State<MyFirebaseConnection> createState() => _MyFirebaseConnectionState();
}

class _MyFirebaseConnectionState extends State<MyFirebaseConnection> {
  bool isConnected = false;
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    if(isError) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.errorMessage!,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    else if(!isConnected) {
      return Center(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/jewel_shop.png"),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }
    else {
      return widget.builder!(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _khoitaoFirebase();
  }

  _khoitaoFirebase() {
    Firebase.initializeApp()
        .then((value) { //try
          setState(() {
            isConnected = true;
          });
        })
        .catchError((error) { //catch
          setState(() {
            isError = true;
          });
        })
        .whenComplete(() => print("Init completed.")); //finally
  }
}


