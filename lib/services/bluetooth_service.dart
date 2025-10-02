import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothService {
  final Strategy strategy = Strategy.P2P_STAR; // one host, many clients
 
Future<void> requestBluetoothPermissions() async {
  await [
    Permission.bluetooth,
    Permission.bluetoothAdvertise,
    Permission.bluetoothConnect,
    Permission.bluetoothScan,
    Permission.location,
  ].request();
}

  // Start advertising as host
  Future<void> startHosting(
      String playerName,
      Function(String, String) onConnectionInitiated,
      Function(String) onConnected,
      Function(String) onDisconnected,
      ) async {
    try {
      await Nearby().startAdvertising(
        playerName,
        strategy,
        onConnectionInitiated: (id, info) {
          onConnectionInitiated(id, info.endpointName);
          Nearby().acceptConnection(id, onPayLoadRecieved: (endpointId, payload) {
            if (payload.type == PayloadType.BYTES) {
              debugPrint("Received: ${String.fromCharCodes(payload.bytes!)}"); // Changed from onPayLoadRec to onPayloadRecieved
            }
          }, );
        },
        onConnectionResult: (id, status) {
          if (status == Status.CONNECTED) onConnected(id);
        },
        onDisconnected: (id) => onDisconnected(id),
      );
    } catch (e) {
      print(e);
    }
  }

  // Start discovering as client
  Future<void> startDiscovering(
      String playerName,
      Function(String, String) onEndpointFound,
      Function(String) onEndpointLost,
      ) async {
    try {
      await Nearby().startDiscovery(
        playerName,
        strategy,
        onEndpointFound: (id, name, serviceId) {
          onEndpointFound(id, name);
        },
        onEndpointLost: (id) => onEndpointLost(id!),
      );
    } catch (e) {
      print(e);
    }
  }

  // Send message
  void sendMessage(String id, String message) {
    Nearby().sendBytesPayload(id, Uint8List.fromList(message.codeUnits));
  }

  void stopAll() {
    Nearby().stopAdvertising();
    Nearby().stopDiscovery();
    Nearby().stopAllEndpoints();
  }
}
