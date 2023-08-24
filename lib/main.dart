import 'package:chess_offline/Boards/board_factory.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:chess_offline/ui/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => GameProvider(BoardFactory().fromFEN(
                "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")))
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'chess',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MenuPage());
  }
}
