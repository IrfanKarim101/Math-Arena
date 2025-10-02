import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_arena/screens/home.dart';
import 'package:math_arena/screens/play_bluetooth/bluetooth_sscreen.dart';
import 'package:math_arena/screens/play_online/create_room.dart';
import 'package:math_arena/screens/play_online/game_screen.dart';
import 'package:math_arena/screens/play_online/join_room.dart';
import 'package:math_arena/screens/play_online/options.dart';
import 'package:math_arena/screens/play_online/random_match.dart';
// Import your bloc
import 'package:math_arena/bloc/room_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoomBloc>(create: (_) => RoomBloc()),
        // Add other BlocProviders here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Math Arena',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
        routes: {
          // '/': (context) => const HomeScreen(),
          '/play_online_options': (context) => const OnlinePlayOptions(),
          '/create_room': (context) => const CreateRoomScreen(),
          '/join_room': (context) => const JoinRoomScreen(),
          '/random_play': (context) => const RandomPlayScreen(),
          '/game_screen': (context) =>
              GameScreen(gameId: "ABC123", player: "You"),
          '/play_bluetooth': (context) => const BluetoothScreen(),
        },
      ),
    );
  }
}
