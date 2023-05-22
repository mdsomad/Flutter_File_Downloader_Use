import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutterdownloder_using/dio_examplePgae_Tow/dio_example_page_tow_dart.dart';
import 'package:flutterdownloder_using/dio_example_Page_One/dio_example_page_one.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DioExamplePageTow(),
    );
  }
}

