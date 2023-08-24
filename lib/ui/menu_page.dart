import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget{
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          ElevatedButton(
            onPressed: () {  },
            child: Text("Новая партия"),
          ),
          ElevatedButton(
            onPressed: () {  },
            child: Text("Загрузить"),
          ),
        ],
      )),
    );
  }

}