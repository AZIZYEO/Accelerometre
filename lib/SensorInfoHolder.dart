import 'package:flutter/material.dart';

class SensorInfoHolder {
  SensorInfoHolder(
      this.name,
      this.type,
      this.vendorName,
      this.version,
     /* this.power,
      this.resolution,
      this.maxRange,
      this.maxDelay,
      this.minDelay,
      this.reportingMode,
      this.isWakeup,
      this.isDynamic,
      this.highestDirectReportRateValue,
      this.fifoMaxEventCount,*/
      this.fifoReservedEventCount) {
    type = '${_getTypeToName(type)} ($type)';
  }
  String name;
  String type;
  String vendorName;
  String version;
/*  String power;
  String resolution;
  String maxRange;
  String maxDelay;
  String minDelay;
  String reportingMode;
  String isWakeup;
  String isDynamic;
  String highestDirectReportRateValue;
  String fifoMaxEventCount;*/
  String fifoReservedEventCount;
  String _getTypeToName(String type) {
    return <String, String>{
      '1': 'Accelerometer',
      '2': 'Gyroscope',
      '3': 'Heeat Beat',
      '4': 'Motion Detect',

    }[type];
  }

  List<Widget> displaySensorData() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            this.name,
            style: TextStyle(
                color: Colors.cyanAccent, fontStyle: FontStyle.italic),
          ),
          Text(
            this.vendorName,
            style: TextStyle(
                color: Colors.greenAccent, fontWeight: FontWeight.bold),
          )
        ],
      ),
      Divider(
        height: 14.0,
        color: Colors.black54,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Type',
          ),
          Text(
            this.type,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Version',
          ),
          Text(
            this.version,
          ),
        ],
      ),
    /*
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Power',
          ),
          Text(
            '${this.power} mA',
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Resolution',
          ),
          Text(
            '${this.resolution} unit',
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Maximum Range',
          ),
          Text(
            '${this.maxRange} unit',
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Maximum Delay',
          ),
          Text(
            '${this.maxDelay} s',
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Minimum Delay',
          ),
          Text(
            '${this.minDelay} s',
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Reporting Mode',
          ),
          Text(
            <String, String>{
              '0': 'Continuous',
              '1': 'On Change',
              '2': 'One Shot',
              '3': 'Special Trigger',
              'NA': 'NA',
            }[this.reportingMode],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Wake Up',
          ),
          Text(
            this.capitalize(this.isWakeup),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Dynamic',
          ),
          Text(
            this.capitalize(this.isDynamic),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Highest Direct Report Rate Value',
          ),
          Text(
            <String, String>{
              '0': 'Unsupported',
              '1': 'Normal',
              '2': 'Fast',
              '3': 'Very Fast',
              'NA': 'NA',
            }[this.highestDirectReportRateValue],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Fifo Max Event Count',
          ),
          Text(
            this.fifoMaxEventCount,
          ),
        ],
      ),
      */
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Fifo Reserved Event Count',
          ),
          Text(
            this.fifoReservedEventCount,
          ),
        ],
      )
    ];
  }

  List<Widget> appendThem(List<Widget> myList) {
    List<Widget> target = this.displaySensorData();
    myList.forEach((Widget element) {
      target.add(element);
    });
    return target;
  }

  String capitalize(String str) {
    return str.replaceFirst(str[0], str[0].toUpperCase());
  }
}

class Accelerometer {
  // type 1
  Accelerometer(this.sensor, this.x, this.y, this.z);
  SensorInfoHolder sensor;
  String x;
  String y;
  String z;
  Card getCard() {
    return Card(
      // Accelerometer
      margin: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
      elevation: 8.0,
      child: Container(
        child: Column(
          children: this.sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Along X-axis'),
                Text('${this.x} m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Along Y-axis'),
                Text('${this.y} m/s^2'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Along Z-axis'),
                Text('${this.z} m/s^2'),
              ],
            )
          ]),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.white,
            width: 0.7,
            style: BorderStyle.solid,
          ),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class Gyroscope {
  // type 2
  Gyroscope(this.sensor, this.angularSpeedAroundX, this.angularSpeedAroundY,
      this.angularSpeedAroundZ);
  SensorInfoHolder sensor;
  String angularSpeedAroundX;
  String angularSpeedAroundY;
  String angularSpeedAroundZ;
  Card getCard() {
    return Card(
      // Gyroscope
      margin: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
      elevation: 8.0,
      child: Container(
        child: Column(
          children: this.sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Angular Speed around X'),
                Text('${this.angularSpeedAroundX} rad/s'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Angular Speed around Y'),
                Text('${this.angularSpeedAroundY} rad/s'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Angular Speed around Z'),
                Text('${this.angularSpeedAroundZ} rad/s'),
              ],
            ),
          ]),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.white,
            width: 0.7,
            style: BorderStyle.solid,
          ),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class HeartBeat {
  // type 3
  HeartBeat(this.sensor, this.confidence);
  SensorInfoHolder sensor;
  String confidence;
  Card getCard() {
    return Card(
      // HeartBeat Sensor
      margin: EdgeInsets.only(top: 6.0, bottom: 6.0, left: 4.0, right: 4.0),
      elevation: 8.0,
      child: Container(
        child: Column(
          children: this.sensor.appendThem([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Confidence'),
                Text('${this.confidence}'),
              ],
            ),
          ]),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.white,
            width: 0.7,
            style: BorderStyle.solid,
          ),
        ),
        padding:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
      ),
    );
  }
}

class MotionDetect {
  // type 4
  MotionDetect(this.sensor, this.isInMotion);
  SensorInfoHolder sensor;
  String isInMotion;

  String getStateText() {
    return this.isInMotion == '1.0'
        ? 'Device in Motion'
        : 'Device not in Motion';
  }
