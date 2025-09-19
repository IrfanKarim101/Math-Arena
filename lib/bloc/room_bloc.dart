import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitial()) {
    on<CreateRoomEvent>((event, emit) {
      emit(RoomCreated(roomCode: "ABC123", players: ["You"]));
    });

    on<JoinRoomEvent>((event, emit) {
      emit(RoomJoined(roomCode: event.roomCode, players: ["You", "Player2"]));
    });

    on<PlayerJoinedEvent>((event, emit) {
      if (state is RoomCreated) {
        final current = state as RoomCreated;
        final updatedPlayers = List<String>.from(current.players)
          ..add(event.playerName);
        emit(RoomCreated(roomCode: current.roomCode, players: updatedPlayers));
      }
    });
  }
}
