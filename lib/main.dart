import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/board.dart';
import 'package:chess_offline/board_console_renderer.dart';
import 'package:chess_offline/board_factory.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _slider = 0;

  void _incrementCounter() {
    setState(() {
      Board board = BoardFactory().fromFEN(
          //"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
          "3k4/6n1/8/2N5/8/8/8/B2K4 w - - 0 1");

      BoardConsoleRenderer renderer = BoardConsoleRenderer();
      renderer.render(board, board.getPiece(Coordinates(File.A, 1)));
      //Piece piece = board.getPiece(Coordinates(File.B, 1));
      //var availableMoveSquares = piece.getAvailableMoveSquares(board);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Сегодня: ${DateTime.now()}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Какое у Вас настроение?\n',
            ),
            /*Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(
                    Icons.sentiment_dissatisfied_sharp,
                    size: 35,
                  ),
                  Icon(
                    Icons.sentiment_dissatisfied,
                    size: 35,
                  ),
                  Icon(
                    Icons.sentiment_neutral,
                    size: 35,
                  ),
                  Icon(
                    Icons.sentiment_satisfied,
                    size: 50,
                    color: Colors.green,
                  ),
                  Icon(
                    Icons.sentiment_satisfied_alt_sharp,
                    size: 35,
                  ),
                ],
              ),
            ),
            Slider(
              value: _slider,
              onChanged: (newRating) {
                setState(() {
                  _slider = newRating;
                });
              },
              min: -2,
              max: 2,
              divisions: 4,
            ),
            Container(
              height: 40,
            ),
            const Text(
              'Опишите Ваши впечатления:\n',
            ),
            Container(
              color: const Color(0x30808080),
              width: 300,
              height: 250,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Я покакал"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment ',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
