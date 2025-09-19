part of 'room_bloc.dart';

sealed class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}
class CreateRoomEvent extends RoomEvent {}

class JoinRoomEvent extends RoomEvent {
  final String roomCode;
  const JoinRoomEvent(this.roomCode);

  @override // Changed from List<Object?> to List<Object>
  List<Object> get props => [roomCode];
}

class PlayerJoinedEvent extends RoomEvent {
  final String playerName;
  const PlayerJoinedEvent(this.playerName);

  @override
  List<Object> get props => [playerName];
}