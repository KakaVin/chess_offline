import 'package:chess_offline/Boards/board_utils.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:chess_offline/ui/game_page.dart';
import 'package:chess_offline/ui/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => GameProvider(BoardUtils.defaultBoard))
      ],
      child: const MyApp(),
    ),
  );
}

final routes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: MenuPage()),
    '/game': (_) => const MaterialPage(child: GamePage()),
    //'/load' (_) => MaterialPage(child: //todo load page),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routes),
      routeInformationParser: const RoutemasterParser(),
      title: "Chess",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
