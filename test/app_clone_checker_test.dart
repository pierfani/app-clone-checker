import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_clone_checker/app_clone_checker.dart';

void main() {
  const MethodChannel channel = MethodChannel('app_clone_checker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AppCloneChecker.platformVersion, '42');
  });
}
