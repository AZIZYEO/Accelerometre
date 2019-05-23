import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SensorInfoHolder.dart';

void main() => runApp(SensorMain());

class SensorMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data_system',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => SensorMainHome(),
      },
    );
  }
}

class SensorMainHome extends StatefulWidget {
  @override
  _SensorMainState createState() => _SensorMainState();
}

SensorInfoHolder getMeAnInstanceOfSensorInfoHolder(Map<String, String> data) {
  return SensorInfoHolder(
      data['name'],
      data['type'],
      data['vendorName'],
      data['version'],
      data['power'],
     );
} // gets an instance of SensorInfoHolder class with required data stored, which is supplied to the function in form of a map/ dictionary

class _SensorMainState extends State<SensorMainHome> {
  static String _methodChannelName =
      'com.example.itzmeanjan.sensorz.androidMethodChannel'; // keep it unique
  static String _eventChannelName =
      'com.example.itzmeanjan.sensorz.androidEventChannel'; // keep it unique too
  static MethodChannel _methodChannel;
  static EventChannel _eventChannel;
  bool _isFirstUIBuildDone = false;
  List<Accelerometer> _listAccelerometer = [];
  List<Gyroscope> _listGyroscope = [];
  List<HeartBeat> _listHeartBeat = [];
  List<MotionDetect> _listMotionDetect = [];


  Future<void> getSensorsList() async {
    Map<String, List<dynamic>> sensorCount;
    try {
      Map<dynamic, dynamic> tmp =
          await _methodChannel.invokeMethod('getSensorsList');
      sensorCount = Map<String, List<dynamic>>.from(tmp);
      sensorCount.forEach((String key, List<dynamic> value) {
        switch (key) {
          case '1':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listAccelerometer.add(Accelerometer(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;

          case '2':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listGyroscope.add(Gyroscope(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA',
                    'NA',
                    'NA'));
              });
            }
            break;

          case '3':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listHeartBeat.add(HeartBeat(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              });
            }

            break;


          case '4':
            if (value.length > 0) {
              value.forEach((dynamic element) {
                _listMotionDetect.add(MotionDetect(
                    getMeAnInstanceOfSensorInfoHolder(
                        Map<String, String>.from(element)),
                    'NA'));
              });
            }
            break;

          default:
          //not supported yet
        }
      });
    } on PlatformException {}
    setState(() {
      // UI rebuilding is done here
      _isFirstUIBuildDone = true;
    });
  }

  @override
  void initState() {
    // stateful widget initialization done here
    super.initState();
    _methodChannel = MethodChannel(_methodChannelName);
    _eventChannel = EventChannel(_eventChannelName);
    getSensorsList();
    _eventChannel.receiveBroadcastStream().listen(_onData, onError: _onError);
  }

  bool isAMatch(SensorInfoHolder data, Map<String, String> receivedData) {
    // Finds whether it is an instance of target class so that we can use it to update UI.
    return (data.name == receivedData['name'] &&
        data.vendorName == receivedData['vendorName'] &&
        data.version == receivedData['version']);
  }

  void _onData(dynamic event) {
    // on sensor data reception, update data holders of different supported sensor types
    if (!_isFirstUIBuildDone) return;
    Map<String, String> receivedData = Map<String, String>.from(event);
    switch (receivedData['type']) {
      case '1':
        _listAccelerometer.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            setState(() {
              item.x = sensorFeed[0];
              item.y = sensorFeed[1];
              item.z = sensorFeed[2];
            });
          }
        });
        break;


      case '2':
        _listGyroscope.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            setState(() {
              item.angularSpeedAroundX = sensorFeed[0];
              item.angularSpeedAroundY = sensorFeed[1];
              item.angularSpeedAroundZ = sensorFeed[2];
            });
          }
        });
        break;

      case '3':
        _listHeartBeat.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            setState(() {
              item.confidence = sensorFeed[0];
              //print(sensorFeed);
            });
          }
        });
        break;


      case '4':
        _listMotionDetect.forEach((item) {
          if (isAMatch(item.sensor, receivedData)) {
            List<String> sensorFeed = receivedData['values'].split(';');
            setState(() {
              item.isInMotion = sensorFeed[0];
            });
          }
        });
        break;
      default:
      //not supported yet
    }
  }

  void _onError(dynamic error) {} // not handling errors yet :)

  List<Widget> buildUI() {
    // main UI rendering operation is performed here, be careful
    List<Widget> tmpUI = [];
    <List<dynamic>>[
      _listAccelerometer,
      _listGyroscope,
      _listHeartBeat,
      _listMotionDetect,

    ].forEach((List<dynamic> elem) {
      elem.forEach((dynamic item) {
        tmpUI.add(item.getCard());
      });
    });
    return tmpUI;
  }

  @override
  Widget build(BuildContext context) {
    // well this is one pretty much compulsory function, which I'm overriding here
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Accelerometre',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.cyanAccent,
      ),
      body: ListView(padding: EdgeInsets.all(6.0), children: buildUI()),
    );
  }
}
