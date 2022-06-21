import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_map_resize_test/show_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  if (Platform.isAndroid) AndroidGoogleMapsFlutter.useAndroidViewSurface = true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShowPage(),
    );
  }
}