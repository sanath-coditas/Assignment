import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BluetoothControl extends StatefulWidget {
  const BluetoothControl({super.key});

  @override
  BluetoothControlState createState() => BluetoothControlState();
}

class BluetoothControlState extends State<BluetoothControl> {
  static const platform = MethodChannel('bluetooth_channel');

  Future<void> enableBluetooth() async {
    try {
      await platform.invokeMethod('enableBluetooth');
    } on PlatformException {}
  }

  Future<void> disableBluetooth() async {
    try {
      await platform.invokeMethod('disableBluetooth');
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: enableBluetooth,
              child: const Text('Enable Bluetooth'),
            ),
            ElevatedButton(
              onPressed: disableBluetooth,
              child: const Text('Disable Bluetooth'),
            ),
          ],
        ),
      ),
    );
  }
}
