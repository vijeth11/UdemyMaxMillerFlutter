import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
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
  int _batterylevel = 0;

  Future<void> _getBatteryLevel() async {
    // ref https://docs.flutter.dev/development/platform-integration/platform-channels?tab=android-channel-java-tab
    // Create the method in android->app->src->main->java->com->MainActivity.java
    // the cannel name should be same as the channel written below
    const platform = MethodChannel('course.flutter.dev/battery');
    try {
      final batteryLevel = await platform.invokeMethod("getBatteryLevel");
      setState(() {
        _batterylevel = batteryLevel;
      });
    } on PlatformException catch (error) {
      print(error);
      setState(() {
        _batterylevel = 0;
      });
    }
  }

  @override
  void initState() {
    _getBatteryLevel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Native Code"),
      ),
      body: Center(
        child: Text("Battery level: $_batterylevel"),
      ),
    );
  }
}
