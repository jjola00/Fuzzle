import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

/// Manages Bluetooth operations including device discovery, pairing, and connection state.
/// Provides a clean interface for the UI to interact with Bluetooth functionality
/// without exposing complex FlutterBluePlus implementation details.
class BluetoothService {
  static final BluetoothService _instance = BluetoothService._internal();
  factory BluetoothService() => _instance;
  BluetoothService._internal();

  BluetoothDevice? _connectedDevice;
  StreamSubscription<List<ScanResult>>? _scanSubscription;
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  
  /// Current Bluetooth adapter state (on/off/unavailable)
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  BluetoothAdapterState get adapterState => _adapterState;
  
  /// List of discovered devices during scanning
  List<ScanResult> _discoveredDevices = [];
  List<ScanResult> get discoveredDevices => _discoveredDevices;
  
  /// Whether the service is currently scanning for devices
  bool _isScanning = false;
  bool get isScanning => _isScanning;
  
  /// Connected device information
  BluetoothDevice? get connectedDevice => _connectedDevice;
  
  /// Stream controllers for notifying UI of state changes
  final StreamController<BluetoothAdapterState> _stateController = StreamController.broadcast();
  final StreamController<List<ScanResult>> _devicesController = StreamController.broadcast();
  final StreamController<bool> _scanningController = StreamController.broadcast();
  
  Stream<BluetoothAdapterState> get stateStream => _stateController.stream;
  Stream<List<ScanResult>> get devicesStream => _devicesController.stream;
  Stream<bool> get scanningStream => _scanningController.stream;

  /// Initialize Bluetooth service and check current state
  Future<void> initialize() async {
    try {
      debugPrint('Initializing Bluetooth service...');
      
      // Check if Bluetooth is supported on this device
      if (await FlutterBluePlus.isSupported == false) {
        debugPrint("Bluetooth not supported by this device");
        return;
      }
      
      debugPrint('Bluetooth is supported on this device');
      
      // Check if Bluetooth is available
      bool isAvailable = await FlutterBluePlus.isAvailable;
      debugPrint('Bluetooth is available: $isAvailable');
      
      // Monitor Bluetooth adapter state changes
      _adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) {
        debugPrint('Bluetooth adapter state changed to: $state');
        _adapterState = state;
        _stateController.add(state);
      });
      
      // Get initial Bluetooth adapter state
      _adapterState = await FlutterBluePlus.adapterState.first;
      debugPrint('Initial Bluetooth adapter state: $_adapterState');
      _stateController.add(_adapterState);
      
      debugPrint('Bluetooth service initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize Bluetooth service: $e');
      rethrow;
    }
  }

  /// Check if Bluetooth is available and ready for use
  Future<bool> isBluetoothAvailable() async {
    try {
      if (await FlutterBluePlus.isSupported == false) {
        debugPrint("Bluetooth not supported");
        return false;
      }
      
      bool isAvailable = await FlutterBluePlus.isAvailable;
      debugPrint('Bluetooth availability check: $isAvailable');
      
      return isAvailable;
    } catch (e) {
      debugPrint('Error checking Bluetooth availability: $e');
      return false;
    }
  }

  /// Request necessary permissions for Bluetooth operations
  /// Returns true if all permissions are granted
  Future<bool> requestPermissions() async {
    try {
      debugPrint('Starting Bluetooth permission request...');
      
      // Request permissions based on platform
      List<Permission> permissions = [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.location,
      ];
      
      // Check current status before requesting
      for (Permission permission in permissions) {
        PermissionStatus status = await permission.status;
        debugPrint('Permission $permission current status: $status');
      }
      
      debugPrint('Requesting permissions: $permissions');
      Map<Permission, PermissionStatus> statuses = await permissions.request();
      
      // Log the results
      for (Permission permission in permissions) {
        PermissionStatus status = statuses[permission] ?? PermissionStatus.denied;
        debugPrint('Permission $permission result: $status');
      }
      
      // Check if all required permissions are granted
      bool allGranted = statuses.values.every((status) => status.isGranted);
      
      if (!allGranted) {
        debugPrint('Some Bluetooth permissions were denied');
        
        // Check for permanently denied permissions
        for (Permission permission in permissions) {
          PermissionStatus status = statuses[permission] ?? PermissionStatus.denied;
          if (status.isPermanentlyDenied) {
            debugPrint('Permission $permission is permanently denied');
          }
        }
        
        return false;
      }
      
      debugPrint('All Bluetooth permissions granted successfully');
      return true;
    } catch (e) {
      debugPrint('Failed to request Bluetooth permissions: $e');
      return false;
    }
  }

  /// Start discovery of nearby Bluetooth devices
  /// Clears previous results and begins fresh scan
  Future<void> startDiscovery() async {
    if (_isScanning) {
      debugPrint('Already scanning for devices');
      return;
    }
    
    try {
      debugPrint('Clearing previous discovered devices...');
      _discoveredDevices.clear();
      _devicesController.add(_discoveredDevices);
      
      debugPrint('Setting scanning state to true...');
      _isScanning = true;
      _scanningController.add(true);
      
      // Start scanning for devices
      debugPrint('Starting Bluetooth scan...');
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 15),
        androidUsesFineLocation: false,
      );
      
      // Listen for scan results
      debugPrint('Setting up scan results listener...');
      _scanSubscription = FlutterBluePlus.scanResults.listen(
        (results) {
          debugPrint('Received scan results: ${results.length} devices');
          _discoveredDevices = results;
          _devicesController.add(_discoveredDevices);
          
          // Log discovered devices
          for (ScanResult result in results) {
            final deviceName = result.device.platformName.isNotEmpty ? result.device.platformName : 'Unknown';
            debugPrint('Discovered device: $deviceName (${result.device.remoteId}) - Signal: ${result.rssi}dBm');
          }
        },
        onError: (error) {
          debugPrint('Scan error: $error');
          _stopDiscovery();
        },
      );
      
      // Stop scanning subscription
      if (_isScanningSubscription != null) {
        await _isScanningSubscription!.cancel();
        _isScanningSubscription = null;
      }
      );
      
      // Listen for scan completion
      _isScanningSubscription = FlutterBluePlus.isScanning.listen((isScanning) {
        debugPrint('Scan state changed: $isScanning');
        if (!isScanning && _isScanning) {
          debugPrint('Scan completed, stopping discovery...');
          _stopDiscovery();
        }
      });
      
      debugPrint('Bluetooth scan started successfully');
      
    } catch (e) {
      debugPrint('Failed to start discovery: $e');
      _stopDiscovery();
      rethrow;
    }
  }

  /// Stop ongoing device discovery
  void _stopDiscovery() {
    debugPrint('Stopping device discovery...');
    _scanSubscription?.cancel();
    _scanSubscription = null;
    _isScanning = false;
    _scanningController.add(false);
    debugPrint('Discovery stopped');
  }

  /// Stop device discovery manually
  Future<void> stopDiscovery() async {
    try {
      debugPrint('Manual stop discovery requested...');
      await FlutterBluePlus.stopScan();
      _stopDiscovery();
    } catch (e) {
      debugPrint('Error stopping scan: $e');
    }
  }

  /// Connect to a device for data communication
  /// Returns true if connection was successful
  Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      debugPrint('Connecting to device: ${device.platformName.isNotEmpty ? device.platformName : 'Unknown'} (${device.remoteId})');
      
      // Disconnect from current device if any
      await disconnect();
      
      // Connect to the device
      await device.connect(timeout: const Duration(seconds: 15));
      _connectedDevice = device;
      
      debugPrint('Successfully connected to device');
      return true;
    } catch (e) {
      debugPrint('Failed to connect to device: $e');
      return false;
    }
  }

  /// Disconnect from currently connected device
  Future<void> disconnect() async {
    if (_connectedDevice != null) {
      try {
        await _connectedDevice!.disconnect();
        _connectedDevice = null;
        debugPrint('Disconnected from device');
      } catch (e) {
        debugPrint('Error disconnecting: $e');
      }
    }
  }

  /// Get list of bonded/paired devices
  /// Note: flutter_blue_plus doesn't provide bonded devices directly
  /// This method returns connected devices instead
  Future<List<BluetoothDevice>> getBondedDevices() async {
    try {
      return FlutterBluePlus.connectedDevices;
    } catch (e) {
      debugPrint('Failed to get connected devices: $e');
      return [];
    }
  }

  /// Turn on Bluetooth adapter (Android only)
  Future<bool> turnOnBluetooth() async {
    try {
      debugPrint('Attempting to turn on Bluetooth...');
      
      if (await FlutterBluePlus.isSupported == false) {
        debugPrint("Bluetooth not supported");
        return false;
      }
      
      // Check current state
      BluetoothAdapterState currentState = await FlutterBluePlus.adapterState.first;
      debugPrint('Current Bluetooth state before turning on: $currentState');
      
      if (currentState == BluetoothAdapterState.on) {
        debugPrint('Bluetooth is already on');
        return true;
      }
      
      // Request to turn on Bluetooth
      await FlutterBluePlus.turnOn();
      
      // Wait for state change with timeout
      int attempts = 0;
      const int maxAttempts = 10;
      
      while (attempts < maxAttempts) {
        BluetoothAdapterState newState = await FlutterBluePlus.adapterState.where((state) => state == BluetoothAdapterState.on).first;
        debugPrint('Bluetooth state after turn on attempt ${attempts + 1}: $newState');
        
        if (newState == BluetoothAdapterState.on) {
          debugPrint('Bluetooth turned on successfully');
          return true;
        }
        
        await Future.delayed(const Duration(milliseconds: 500));
        attempts++;
      }
      
      debugPrint('Failed to turn on Bluetooth after $maxAttempts attempts');
      return false;
    } catch (e) {
      debugPrint('Failed to turn on Bluetooth: $e');
      return false;
    }
  }

  /// Clean up resources when service is no longer needed
  void dispose() {
    _scanSubscription?.cancel();
    _adapterStateSubscription?.cancel();
    _connectedDevice?.disconnect();
    _stateController.close();
    _devicesController.close();
    _scanningController.close();
  }
} 