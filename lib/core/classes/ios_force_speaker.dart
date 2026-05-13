import 'package:flutter/services.dart';

class AudioHelper {
  static const MethodChannel _channel = MethodChannel('audio_channel');

  static Future<void> forceSpeaker() async {
    try {
      await _channel.invokeMethod('forceSpeaker');
    } on PlatformException catch (e) {
      print("Failed to set audio to speaker: '${e.message}'.");
    }
  }
}
