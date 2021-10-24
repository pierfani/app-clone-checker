
import 'dart:async';

import 'package:flutter/services.dart';

class AppCloneChecker {
  static const MethodChannel _channel = MethodChannel('app_clone_checker');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<dynamic> appOriginality(String applicationID) async {
    return await _channel.invokeMethod('checkDeviceCloned',{"applicationID" : applicationID});
  }


}
