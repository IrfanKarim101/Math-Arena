// peer to peer connection service using nearby_connections package to play locally
import 'dart:async';
import 'dart:typed_data';
import 'package:nearby_connections/nearby_connections.dart';

class PeerToPeerService {
  final Strategy strategy = Strategy.P2P_STAR;
  final String userName;
  final String serviceId = "com.example.math_arena";
  late final StreamController<String> _messageController;
  Stream<String> get messages => _messageController.stream;
  late final StreamController<List<String>> _peersController;
  Stream<List<String>> get peers => _peersController.stream;

  PeerToPeerService(this.userName) {
    _messageController = StreamController<String>.broadcast();
    _peersController = StreamController<List<String>>.broadcast();
  }

  void dispose() {
    _messageController.close();
    _peersController.close();
  }

  // Maintain a local list of connected endpoints
  final List<String> _connectedEndpoints = [];

  Future<void> startAdvertising() async {
    bool advertising = await Nearby().startAdvertising(
      userName,
      strategy,
      onConnectionInitiated: _onConnectionInitiated,
      onConnectionResult: (id, status) {
        if (status == Status.CONNECTED) {
          print("Connected to $id");
          if (!_connectedEndpoints.contains(id)) {
            _connectedEndpoints.add(id);
            _updatePeers();
          }
        }
      },
      onDisconnected: (id) {
        print("Disconnected from $id");
        _connectedEndpoints.remove(id);
        _updatePeers();
      },
    );
    print('Advertising: $advertising');
  }

  Future<void> startDiscovery() async {
    bool discovery = await Nearby().startDiscovery(
      userName,
      strategy,
      onEndpointFound: _onEndpointFound,
      onEndpointLost: (id) {
        print("Lost endpoint $id");
        _connectedEndpoints.remove(id);
        _updatePeers();
      },
    );
    print('Discovery: $discovery');
  }

  Future<void> sendMessage(String message) async {
    for (var id in _connectedEndpoints) {
      Nearby().sendBytesPayload(id, Uint8List.fromList(message.codeUnits));
    }
  }

  void _onConnectionInitiated(String id, ConnectionInfo info) {
    Nearby().acceptConnection(
      id,
      onPayLoadRecieved: (endid, payload) {
        if (payload.type == PayloadType.BYTES) {
          String message = String.fromCharCodes(payload.bytes!);
          _messageController.add(message);
        }
      },
      onPayloadTransferUpdate: (endid, payloadTransferUpdate) {},
    );
    if (!_connectedEndpoints.contains(id)) {
      _connectedEndpoints.add(id);
      _updatePeers();
    }
  }

  void _onEndpointFound(String id, String name, String serviceId) {
    Nearby().requestConnection(
      userName,
      id,
      onConnectionInitiated: (id, info) {
        _onConnectionInitiated(id, info);
      },
      onConnectionResult: (id, status) {
        if (status == Status.CONNECTED) {
          print("Connected to $id");
          if (!_connectedEndpoints.contains(id)) {
            _connectedEndpoints.add(id);
            _updatePeers();
          }
        }
      },
      onDisconnected: (id) {
        print("Disconnected from $id");
        _connectedEndpoints.remove(id);
        _updatePeers();
      },
    );
    // No need to call _updatePeers() here, only after connection is established
  }

  void _updatePeers() {
    _peersController.add(List<String>.from(_connectedEndpoints));
  }

  Future<void> stopAllEndpoints() async {
    await Nearby().stopAllEndpoints();
  }

  Future<void> stopAdvertising() async {
    await Nearby().stopAdvertising();
  }

  Future<void> stopDiscovery() async {
    await Nearby().stopDiscovery();
  }
}