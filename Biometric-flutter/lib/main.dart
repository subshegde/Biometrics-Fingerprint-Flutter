import 'package:flutter/material.dart';
import 'package:biometric/src/ui/pages/biometric%20scan/biometric_scan_view.dart';
import 'package:biometric/src/ui/pages/home/home_vm.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<HomeViewModel>(
      create: (BuildContext ctx) => HomeViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Biometric',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 39, 39, 43),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const BioMetricScanView(),
    );
  }
}
