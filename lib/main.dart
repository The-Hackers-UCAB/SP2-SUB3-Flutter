// import 'dart:math';

//import 'dart:js';

import 'package:flutter/material.dart';
//import 'package:myonlinedoctor/models/doctor.dart';

import 'package:myonlinedoctor/view/doctor_page.dart';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctores sin filtro',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DoctorPage(),
    );
  }
}
