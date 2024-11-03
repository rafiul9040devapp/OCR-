import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import '../api_setup/injection_container.dart';

Future<Map<String, String>> getDeviceDetails() async {
  DeviceInfoPlugin deviceInfo = sl<DeviceInfoPlugin>();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return {
      'device_id': androidInfo.id ?? 'unknown',  // Device ID
      'device_type': 'Android',
    };
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return {
      'device_id': iosInfo.identifierForVendor ?? 'unknown',  // Device ID
      'device_type': 'iOS',
    };
  }

  return {
    'device_id': 'unknown',
    'device_type': 'unknown',
  };
}
