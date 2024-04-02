import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothManager {
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice? _connectedDevice;

  // Initialize Bluetooth
  Future<void> initBluetooth() async {
    try {
      // Check if Bluetooth is available
      bool? isEnabled = await _bluetooth.isEnabled; // Make isEnabled nullable
      if (!isEnabled!) { // Check if isEnabled is not null
        await _bluetooth.requestEnable();
      }

      // Get a list of paired devices
      List<BluetoothDevice> devices = await _bluetooth.getBondedDevices();
      _devicesList = devices;
    } catch (error) {
      print('Error initializing Bluetooth: $error');
    }
  }

  // Scan for nearby devices
  Future<void> scanDevices() async {
    try {
      _bluetooth.startDiscovery();
      _bluetooth.startDiscovery().listen((device) {
        // Handle BluetoothDiscoveryResult to get BluetoothDevice
        BluetoothDevice btDevice = device.device;
        if (!_devicesList.contains(btDevice)) {
          _devicesList.add(btDevice);
        }
      });
    } catch (error) {
      print('Error scanning devices: $error');
    }
  }

  // Connect to a device
  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await _bluetooth.connect(device);
      _connectedDevice = device;
      print('Connected to device: ${device.name}');
    } catch (error) {
      print('Error connecting to device: $error');
    }
  }

  // Disconnect from the connected device
  Future<void> disconnect() async {
    try {
      await _bluetooth.disconnect();
      _connectedDevice = null;
      print('Disconnected from device');
    } catch (error) {
      print('Error disconnecting: $error');
    }
  }

  // Getters
  List<BluetoothDevice> get devicesList => _devicesList;
  BluetoothDevice? get connectedDevice => _connectedDevice;
}
