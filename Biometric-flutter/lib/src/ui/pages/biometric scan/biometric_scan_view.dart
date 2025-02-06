import 'package:flutter/material.dart';
import 'package:biometric/src/core/utils/snackBar.dart';
import 'package:biometric/src/ui/pages/home/home_view.dart';
import 'package:biometric/src/ui/pages/home/home_vm.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'biometric_scan_vm.dart';

class BioMetricScanView extends StatelessWidget {
  const BioMetricScanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<HomeViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Biometric Scan',style: TextStyle(color: Colors.grey),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: ()async{
               bool _isAuth = await BioMetricScanViewModel().hasBiometrics();
              if (_isAuth) {
                bool _isNextScreen =
                    await BioMetricScanViewModel().authenticate();
                _provider.checkCall(context);
                if (_isNextScreen) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => const HomeView(),
                      ));
                }
              } else {
                showSnackBar(
                    message: 'Authentication Failed!', context: context);
              }
            },
            child: LottieBuilder.asset('assets/lotties/fingerprint_scanning.json')),
        ],
      ),
    );
  }
}
