import 'package:buscador_de_giphy/app/modules/gifpage/gif_model.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPageWidget extends StatelessWidget {
  final GifModel gifModel;

  GifPageWidget({Key key, this.gifModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gifModel.title),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(gifModel
                    .url); //extensão add no pubspec que compartilhar url
              },
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(gifModel.url),
      ),
    );
  }
}
