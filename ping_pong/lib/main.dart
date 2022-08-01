import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';

// ref https://blog.bajarangisoft.com/blog/how-to-use-accelerometer-sensor-using-flutter-android-app
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: "Accelerometer code"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color color = Colors.orange;
  AccelerometerEvent? event;
  Timer? timer;
  StreamSubscription? accel;
  double top = 125;
  double? left;
  int count = 0;
  late double width;
  late double height;

  setColor(AccelerometerEvent event) {
    double x = ((event.x * 12) + ((width - 100) / 2));
    double y = event.y * 12 + 125;
    var xDiff = x.abs() - ((width - 100) / 2);
    var yDiff = y.abs() - 125;
    if (xDiff.abs() < 3 && yDiff.abs() < 3) {
      setState(() {
        color = Colors.blue.shade100;
        count += 2;
      });
    } else {
      setState(() {
        color = Colors.red;
        count = 0;
      });
    }
  }

  setPosition(AccelerometerEvent event) {
    if (event == null) {
      return;
    }
    setState(() {
      left = ((event.x * 12) + ((width - 100) / 2));
    });
    setState(() {
      top = event.y * 12 + 125;
    });
  }

  startTimer() {
    if (accel == null) {
      accel = accelerometerEvents.listen((AccelerometerEvent eve) {
        setState(() {
          event = eve;
        });
      });
    } else {
      accel?.resume();
    }
    if (timer == null || (timer != null && !timer!.isActive)) {
      timer = Timer.periodic(Duration(milliseconds: 200), (_) {
        if (count > 3) {
          pauseTimer();
        } else {
          setColor(event!);
          setPosition(event!);
        }
      });
    }
  }

  pauseTimer() {
    timer?.cancel();
    accel?.pause();
    setState(() {
      count = 0;
      color = Colors.blue.shade900;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    accel?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text(' Accelerometer Sensor'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Keep the circle in the center for 1 second'),
          ),
          Stack(
            children: [
              Container(
                height: height / 2,
                width: width,
              ),
              Positioned(
                top: 50,
                left: (width - 250) / 2,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(125),
                  ),
                ),
              ),
              Positioned(
                top: top,
                left: left ?? (width - 100) / 2,
                child: ClipOval(
                  child: Container(
                    width: 100,
                    height: 100,
                    color: color,
                  ),
                ),
              ),
              Positioned(
                top: 125,
                left: (width - 100) / 2,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
          Text('x: ${(event?.x ?? 0).toStringAsFixed(3)}'),
          Text('y: ${(event?.y ?? 0).toStringAsFixed(3)}'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: startTimer,
              child: Text('Begin'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.red.shade800),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
