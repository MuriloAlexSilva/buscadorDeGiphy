import 'package:buscador_de_giphy/app/modules/gifpage/gif_model.dart';
import 'package:flutter/material.dart';

class GifPage extends StatelessWidget {
  final GifModel gifModel;

  GifPage({Key key, this.gifModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gifModel.title),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(gifModel.url),
      ),
    );
  }
}
