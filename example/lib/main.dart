import 'dart:async';

import 'package:app_clone_checker/app_clone_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  dynamic _appOriginality = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    checkAppValid();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await AppCloneChecker.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkAppValid() async {
    dynamic pluginResponse;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      pluginResponse = await AppCloneChecker.appOriginality(
          "com.vignesh.app_clone_checker",
          isWorkProfileAllowed: false);

      var resultData = ResultData.fromJson(pluginResponse);
      pluginResponse = resultData.message;
    } on PlatformException {
      pluginResponse = 'Failed to get result.';
    }



    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appOriginality = pluginResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Clone Checker'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Running on: $_platformVersion\n'),
            const SizedBox(height: 25,),
            Center(child: Text('Original / Cloned : $_appOriginality\n',textAlign: TextAlign.center,)),
          ],
        ),
      ),
    );
  }
}

class ResultData {
  ResultData({
    this.result,
    this.message,});

  ResultData.fromJson(dynamic json) {
    result = json['result'];
    message = json['message'];
  }
  String? result;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = result;
    map['message'] = message;
    return map;
  }

}
