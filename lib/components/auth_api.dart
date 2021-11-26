import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (error) {
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();

    if (!isAvailable) return false;
    try {
      return await _auth.authenticate(
        localizedReason: 'Scan Face to Authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (error) {
      return false;
    }
  }
}
