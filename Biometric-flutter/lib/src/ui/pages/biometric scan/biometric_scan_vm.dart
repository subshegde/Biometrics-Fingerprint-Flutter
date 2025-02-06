import 'dart:async';
import 'dart:developer';
import 'package:local_auth/local_auth.dart';

class BioMetricScanViewModel {
  LocalAuthentication auth = LocalAuthentication();

  Future<bool> hasBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  Future<bool> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Authenticate to unlock your GitHub repos!',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return didAuthenticate;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
