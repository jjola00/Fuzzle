import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as flutter_blue_plus;
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/constants/app_constants.dart';
import '../shared/services/bluetooth_service.dart' as custom_bluetooth;

/// Device pairing screen that displays available Bluetooth devices and manages pairing process.
/// Provides user feedback during scanning, pairing, and connection states.
class DevicePairingScreen extends StatefulWidget {
  const DevicePairingScreen({super.key});

  @override
  State<DevicePairingScreen> createState() => _DevicePairingScreenState();
}

class _DevicePairingScreenState extends State<DevicePairingScreen> with WidgetsBindingObserver {
  final custom_bluetooth.BluetoothService _bluetoothService = custom_bluetooth.BluetoothService();
  List<flutter_blue_plus.BluetoothDevice> _connectedDevices = [];
  List<flutter_blue_plus.ScanResult> _discoveredDevices = [];
  bool _isScanning = false;
  flutter_blue_plus.BluetoothAdapterState _adapterState = flutter_blue_plus.BluetoothAdapterState.unknown;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeBluetooth();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _bluetoothService.stopDiscovery();
    super.dispose();
  }

  /// Handle app lifecycle state changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint('App lifecycle state changed: $state');
    
    if (state == AppLifecycleState.resumed) {
      // App came back to foreground, refresh Bluetooth state
      debugPrint('App resumed, refreshing Bluetooth state...');
      _refreshBluetoothState();
    }
  }

  /// Called when the screen is revisited
  @override
  void didUpdateWidget(DevicePairingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Refresh the state when screen is revisited
    _refreshBluetoothState();
  }

  /// Refresh Bluetooth state and connected devices
  Future<void> _refreshBluetoothState() async {
    debugPrint('Refreshing Bluetooth state...');
    
    try {
      // Check if Bluetooth is available
      bool isAvailable = await _bluetoothService.isBluetoothAvailable();
      debugPrint('Bluetooth availability on refresh: $isAvailable');
      
      // Get current adapter state directly
      final currentState = await flutter_blue_plus.FlutterBluePlus.adapterState.first;
      debugPrint('Current Bluetooth adapter state on refresh: $currentState');
      
      if (mounted) {
        setState(() {
          _adapterState = currentState;
        });
      }
      
      // Refresh connected devices
      _loadConnectedDevices();
      
    } catch (e) {
      debugPrint('Error refreshing Bluetooth state: $e');
    }
  }

  /// Initialize Bluetooth service and load connected devices
  Future<void> _initializeBluetooth() async {
    try {
      await _bluetoothService.initialize();
      
      // Set up listeners for real-time updates
      _bluetoothService.stateStream.listen((state) {
        if (mounted) {
          setState(() {
            _adapterState = state;
          });
        }
        debugPrint('Bluetooth adapter state changed: $state');
      });

      _bluetoothService.devicesStream.listen((devices) {
        if (mounted) {
          setState(() {
            _discoveredDevices = devices;
          });
        }
        debugPrint('Discovered devices updated: ${devices.length} devices');
        // Log device names for debugging
        for (var device in devices) {
          final deviceName = device.device.platformName.isNotEmpty ? device.device.platformName : 'Unknown';
          debugPrint('Device: $deviceName (${device.device.remoteId}) - Signal: ${device.rssi}dBm');
        }
      });

      _bluetoothService.scanningStream.listen((isScanning) {
        if (mounted) {
          setState(() {
            _isScanning = isScanning;
          });
        }
        debugPrint('Scanning state changed: $isScanning');
      });

      // Load already connected devices and refresh state
      _loadConnectedDevices();
      _refreshBluetoothState();
      
    } catch (e) {
      debugPrint('Failed to initialize Bluetooth: $e');
      _showErrorSnackBar('Failed to initialize Bluetooth: $e');
    }
  }

  /// Load list of already connected devices
  Future<void> _loadConnectedDevices() async {
    try {
      final connectedDevices = await _bluetoothService.getBondedDevices();
      setState(() {
        _connectedDevices = connectedDevices;
      });
      debugPrint('Loaded ${connectedDevices.length} connected devices');
    } catch (e) {
      debugPrint('Failed to load connected devices: $e');
      _showErrorSnackBar('Failed to load connected devices: $e');
    }
  }

  /// Start scanning for nearby devices after requesting permissions
  Future<void> _startScanning() async {
    debugPrint('Starting scan. Current adapter state: $_adapterState');
    
    if (_adapterState != flutter_blue_plus.BluetoothAdapterState.on) {
      debugPrint('Bluetooth adapter is not on. Attempting to turn on...');
      // Try to turn on Bluetooth
      bool turnedOn = await _bluetoothService.turnOnBluetooth();
      if (!turnedOn) {
        _showErrorSnackBar('Please enable Bluetooth to scan for devices');
        return;
      }
      
      // Wait a moment for the adapter to initialize
      await Future.delayed(const Duration(milliseconds: 1000));
    }

    debugPrint('Requesting Bluetooth permissions...');
    bool permissionsGranted = await _bluetoothService.requestPermissions();
    if (!permissionsGranted) {
      await _handlePermissionDenied();
      return;
    }

    debugPrint('Permissions granted. Starting discovery...');
    try {
      await _bluetoothService.startDiscovery();
    } catch (e) {
      debugPrint('Failed to start device scan: $e');
      _showErrorSnackBar('Failed to start device scan: $e');
    }
  }

  /// Handle permission denied scenario
  Future<void> _handlePermissionDenied() async {
    // Check if any permissions are permanently denied
    List<Permission> permissions = [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ];
    
    bool hasPermPermanentlyDenied = false;
    for (Permission permission in permissions) {
      if (await permission.isPermanentlyDenied) {
        hasPermPermanentlyDenied = true;
        break;
      }
    }
    
    if (hasPermPermanentlyDenied) {
      _showPermissionDialog();
    } else {
      _showErrorSnackBar('Bluetooth permissions are required for device scanning. Please grant permissions.');
    }
  }

  /// Show dialog for permission settings
  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissions Required'),
          content: const Text(
            'Bluetooth permissions are required for device scanning. '
            'Please enable Bluetooth, Location, and nearby devices permissions in Settings.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  /// Connect to a device
  Future<void> _connectToDevice(flutter_blue_plus.BluetoothDevice device) async {
    try {
      final deviceName = device.platformName.isNotEmpty ? device.platformName : 'Unknown Device';
      debugPrint('Connecting to device: $deviceName');
      _showLoadingDialog('Connecting to $deviceName...');
      
      bool success = await _bluetoothService.connectToDevice(device);
      
      Navigator.of(context).pop(); // Close loading dialog
      
      if (success) {
        debugPrint('Successfully connected to $deviceName');
        _showSuccessSnackBar('Connected to $deviceName');
        // Refresh connected devices list
        _loadConnectedDevices();
        // Return to home screen after successful connection
        context.go('/');
      } else {
        debugPrint('Failed to connect to $deviceName');
        _showErrorSnackBar('Failed to connect to $deviceName');
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close loading dialog
      debugPrint('Error during connection: $e');
      _showErrorSnackBar('Error during connection: $e');
    }
  }

  /// Display loading dialog with custom message
  void _showLoadingDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 16),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: AppConstants.snackBarDuration + 1),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: AppConstants.snackBarDuration),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Pairing'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshBluetoothState,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: Icon(_isScanning ? Icons.stop : Icons.search),
            onPressed: _isScanning 
                ? () => _bluetoothService.stopDiscovery() 
                : () => _startScanning(),
            tooltip: _isScanning ? 'Stop Scanning' : 'Start Scanning',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (kDebugMode) {
      debugPrint('Building body with ${_discoveredDevices.length} discovered devices');
    }
    
    if (_adapterState == flutter_blue_plus.BluetoothAdapterState.off) {
      return _buildBluetoothOffMessage();
    }

    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Bluetooth status indicator
          _buildBluetoothStatusCard(),
          
          const SizedBox(height: 16),
          
          // Debug information
          _buildDebugCard(),
          
          const SizedBox(height: 16),
          
          // Connected devices section
          if (_connectedDevices.isNotEmpty) ...[
            Text(
              'Connected Devices',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            _buildConnectedDevicesList(),
            const SizedBox(height: 16),
          ],
          
          // Available devices section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Devices',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '(${_discoveredDevices.length})',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          if (_isScanning)
            const LinearProgressIndicator(),
          
          const SizedBox(height: 8),
          
          Expanded(
            child: _buildDiscoveredDevicesList(),
          ),
          
          const SizedBox(height: 16),
          
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }

  Widget _buildBluetoothStatusCard() {
    return Card(
      color: _adapterState == flutter_blue_plus.BluetoothAdapterState.on ? Colors.green.shade100 : Colors.red.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              _adapterState == flutter_blue_plus.BluetoothAdapterState.on ? Icons.bluetooth : Icons.bluetooth_disabled,
              color: _adapterState == flutter_blue_plus.BluetoothAdapterState.on ? Colors.green : Colors.red,
            ),
            const SizedBox(width: 8),
            Text(
              _adapterState == flutter_blue_plus.BluetoothAdapterState.on ? 'Bluetooth Enabled' : 'Bluetooth Disabled',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  /// Debug card to show current state information
  Widget _buildDebugCard() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Debug Information',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text('Adapter State: $_adapterState'),
            Text('Is Scanning: $_isScanning'),
            Text('Connected Devices: ${_connectedDevices.length}'),
            Text('Discovered Devices: ${_discoveredDevices.length}'),
          ],
        ),
      ),
    );
  }

  Widget _buildBluetoothOffMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bluetooth_disabled,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Bluetooth is disabled',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Please enable Bluetooth to pair with devices',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _bluetoothService.turnOnBluetooth,
            child: const Text('Turn On Bluetooth'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _startScanning,
            child: const Text('Check Permissions'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyDeviceList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.devices,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            _isScanning ? 'Scanning for devices...' : 'No devices found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            _isScanning ? 'Please wait while we search for nearby devices' : 'Tap the search icon to scan for devices',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildConnectedDevicesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _connectedDevices.length,
      itemBuilder: (context, index) {
        final device = _connectedDevices[index];
        final deviceName = device.platformName.isNotEmpty ? device.platformName : 'Unknown Device';
        
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(
              Icons.bluetooth_connected,
              color: Colors.green,
            ),
            title: Text(deviceName),
            subtitle: Text('ID: ${device.remoteId}'),
            trailing: ElevatedButton(
              onPressed: () => _connectToDevice(device),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Connect'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDiscoveredDevicesList() {
    debugPrint('Building discovered devices list with ${_discoveredDevices.length} devices');
    
    if (_discoveredDevices.isEmpty) {
      return _buildEmptyDeviceList();
    }

    return ListView.builder(
      itemCount: _discoveredDevices.length,
      itemBuilder: (context, index) {
        final scanResult = _discoveredDevices[index];
        final device = scanResult.device;
        final deviceName = device.platformName.isNotEmpty ? device.platformName : 'Unknown Device';
        
        debugPrint('Building device tile for: $deviceName (${device.remoteId})');
        
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(
              Icons.bluetooth,
              color: AppConstants.bluetoothButtonColor,
            ),
            title: Text(deviceName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${device.remoteId}'),
                Text('Signal: ${scanResult.rssi}dBm'),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () => _connectToDevice(device),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.bluetoothButtonColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Connect'),
            ),
          ),
        );
      },
    );
  }
} 