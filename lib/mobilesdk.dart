import 'dart:async';

import 'package:flutter/services.dart';
import 'package:method_extractor/method_extractor.dart';

/// Glue code between native and flutter dart side. @methodExtractor to mark
/// it for annotation processor to work on and @extractMethod to extract
/// code for generating enums for Kotlin and Swift.
@methodExtractor
class MobileSdk {
  static const MethodChannel _channel = MethodChannel('mobilesdk');

  @extractMethod
  static Future<void> initialize() async {
    await _channel.invokeMethod('initialize');
  }

  @extractMethod
  static Future<void> trigger() async {
    await _channel.invokeMethod('trigger');
  }

  @extractMethod
  static Future<void> validateAnswer(bool didMobileWin) async {
    await _channel
        .invokeMethod('validateAnswer', {'didMobileWin': didMobileWin});
  }
}
