import 'dart:convert';
import 'package:buscador_de_giphy/app/modules/gifpage/gif_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

String search;
int offset = 0;

Future<Map> getGifs() async {
  http.Response response;
  if (search == null || search.isEmpty) {
    response = await http.get(
        'https://api.giphy.com/v1/gifs/trending?api_key=Tx5sEypFAlF6XC8jBT8TNtNQy04EfTQz&limit=25&rating=g');
  } else {
    response = await http.get(
        'https://api.giphy.com/v1/gifs/search?api_key=Tx5sEypFAlF6XC8jBT8TNtNQy04EfTQz&q=$search&limit=19&offset=$offset&rating=g&lang=en');
  }
  return jsonDecode(response.body);
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  void initState() {
    super.initState();
    getGifs().then((map) => print(map));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.network(
              'https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif'),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Pesquise Aqui!',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder()),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
                onSubmitted: (text) {
                  //Ele irá pegar o texto ao clicarmos na seta de busca
                  setState(() {
                    search = text;
                    offset = 0;
                  });
                },
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: getGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      alignment: Alignment.center,
                      height: 200,
                      width: 200,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    );

                  default:
                    if (snapshot.hasError) {
                      return Container();
                    } else {
                      return _createGifTable(context, snapshot);
                    }
                }
              },
            ))
          ],
        ));
  }

  int _getCount(List data) {
    if (search == null) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //Qtdd de itens na width
          crossAxisSpacing: 10, //Espaçamento entre os grids na width
          mainAxisSpacing: 10 // Espaçamento na vertical
          ),
      itemCount: _getCount(snapshot.data['data']),
      itemBuilder: (context, index) {
        if (search == null || index < snapshot.data['data'].length) {
          return GestureDetector(
            child: FadeInImage.memoryNetwork(
              placeholder:
                  kTransparentImage, //O 'kTransparentImage' suaviza o aparecimento das imagens, devido a imagem estar vindo da internet, temos que adicionar
              //no pubspec e utilizar o 'FadeInImage.memoryNetwork'
              image: snapshot.data['data'][index]['images']['fixed_height']
                  ['url'],
              height: 300,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Modular.to.pushNamed('/gifPage',
                  arguments: GifModel(
                      title: snapshot.data['data'][index]['title'],
                      url: snapshot.data['data'][index]['images']
                          ['fixed_height']['url']));
            },
            onLongPress: () {
              Share.share(snapshot.data['data'][index]['images']['fixed_height']
                  ['url']);
              //Para compartilhar o gif via dependencia share
            },
          );
        } else {
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 70,
                    color: Colors.white,
                  ),
                  Text(
                    'Carregar mais...',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  offset += 19;
                });
              },
            ),
          );
        }
      },
    );
  }
}
