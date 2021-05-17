import 'package:buscador_de_giphy/app/modules/gifpage/gif_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => HomePage()),
    ChildRoute('/gifPage',
        child: (context, args) => GifPage(gifModel: args.data)),
  ];
}
