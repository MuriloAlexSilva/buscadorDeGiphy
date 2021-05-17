import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: Colors
            .white, //Seria para colocar a cor quando o TextField não estiver selecionado
      ),
    ).modular();
  }
}
