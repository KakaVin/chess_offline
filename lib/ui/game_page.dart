import 'package:chess_offline/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameWidget extends StatelessWidget{
  const GameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Loading..."),),
      body: Center(
        child: context.read<GameProvider>().boardWidget
      ),
    );
  }


}