import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'bridge_generated.dart';

void main() {
  runApp(const MyApp());
}

const base = 'rust';
final path = Platform.isWindows ? '$base.dll' : 'lib$base.so';
late final dylib = Platform.isIOS
    ? DynamicLibrary.process()
    : Platform.isMacOS
        ? DynamicLibrary.executable()
        : DynamicLibrary.open(path);
late final api = RustImpl(dylib);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    //Call the greet function

    api.greet(hint: "t").then((value) => print("null"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
