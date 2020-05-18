import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';




class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => new _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  String _imagePath = 'Unknown';

  @override
  void initState() {
    super.initState();

  }

  // Platform messages are asynchronous, so we initialize in an async method.


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('Cropped image path: $_imagePath\n'),
        ),
      ),
    );
  }
}
