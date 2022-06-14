// import 'dart:math';

//import 'dart:js';

import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:myonlinedoctor/models/doctor.dart';

import 'package:myonlinedoctor/view/DoctorPage.dart';

import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Listado de Doctores',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DoctorPage(),
    );
  }
}
