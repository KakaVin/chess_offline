import 'package:chess_offline/ui/widgets/board_widget.dart';
import 'package:flutter/material.dart';

class GameWidget extends StatelessWidget{
  const GameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Loading..."),),
      body: Center(
        child: BoardWidget()
      ),
    );
  }


}