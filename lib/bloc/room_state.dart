
part of 'room_bloc.dart';

abstract class RoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoomInitial extends RoomState {}

class RoomCreated extends RoomState {
  final String roomCode;
  final List<String> players;
  RoomCreated({required this.roomCode, required this.players});

  @override
  List<Object?> get props => [roomCode, players];
}

class RoomJoined extends RoomState {
  final String roomCode;
  final List<String> players;
  RoomJoined({required this.roomCode, required this.players});

  @override
  List<Object?> get props => [roomCode, players];
}