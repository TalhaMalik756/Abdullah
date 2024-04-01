import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> _devicesList = [];
  Map<BluetoothDevice, bool> _connectingDevices = {};
  BluetoothDevice? _connectedDevice;

  bool _isScanning = false;
  bool _noDevicesFound = false;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    try {
      bool isEnabled = (await _bluetooth.isEnabled) ?? false;
      if (!isEnabled) {
        await _bluetooth.requestEnable();
      }
      List<BluetoothDevice> devices = await _bluetooth.getBondedDevices();
      setState(() {
        _devicesList = devices;
      });
    } catch (error) {
      print('Error initializing Bluetooth: $error');
    }
  }

  Future<void> _scanDevices() async {
    setState(() {
      _isScanning = true;
      _noDevicesFound = false; // Reset flag when scanning starts
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Searching for devices...'),
      ),
    );

    try {
      _bluetooth.startDiscovery();
      _bluetooth.startDiscovery().listen((device) {
        if (!_devicesList.contains(device)) {
          setState(() {
            _devicesList.add(device as BluetoothDevice);
          });
        }
      });
    } catch (error) {
      print('Error scanning devices: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to scan devices'),
        ),
      );
    } finally {
      setState(() {
        _isScanning = false;
        _noDevicesFound = _devicesList.isEmpty; // Set flag when scanning finishes
      });
    }

    if (_noDevicesFound) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No new devices found'),
        ),
      );
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      setState(() {
        _connectingDevices[device] = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connecting to ${device.name}...'),
        ),
      );

      await _bluetooth.connect(device);

      setState(() {
        _connectedDevice = device;
        _connectingDevices[device] = false;
      });

      if (!_connectingDevices.containsValue(true)) {
        // Show the Snackbar only once when all connections are completed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Connected to ${device.name}'),
          ),
        );
      }
    } catch (error) {
      print('Error connecting to device: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to connect to ${device.name}'),
        ),
      );
      setState(() {
        _connectingDevices[device] = false;
      });
    }
  }

  Future<void> _disconnectFromDevice() async {
    try {
      await _bluetooth.disconnect();
      setState(() {
        _connectedDevice = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Disconnected from device'),
        ),
      );
    } catch (error) {
      print('Error disconnecting: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to disconnect'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFECFFDC),
        title: Text('Bluetooth Devices'),
        actions: [
          IconButton(
            icon: _isScanning ? CircularProgressIndicator() : Icon(Icons.refresh),
            onPressed: _scanDevices,
          ),
        ],
      ),
      backgroundColor: Color(0xFFECFFDC),
      body: ListView.builder(
        itemCount: _devicesList.length,
        itemBuilder: (context, index) {
          BluetoothDevice device = _devicesList[index];
          bool isConnectedToDevice = _connectedDevice != null && _connectedDevice == device;
          bool isConnectingToDevice = _connectingDevices.containsKey(device) && _connectingDevices[device] == true;

          return Card(
            elevation: 2, // Add a slight elevation
            color: Color(0xFFECFFDC), // Match the background color of the interface
            child: ListTile(
              title: Text(device.name ?? '', style: TextStyle(color: Colors.black)),
              subtitle: Text(device.address, style: TextStyle(color: Colors.black)),
              onTap: isConnectingToDevice ? null : () => _connectToDevice(device),
              trailing: isConnectedToDevice
                  ? TextButton(
                onPressed: _disconnectFromDevice,
                child: Text('Disconnect'),
              )
                  : isConnectingToDevice
                  ? CircularProgressIndicator()
                  : null,
            ),
          );
        },
      ),
    );
  }
}
