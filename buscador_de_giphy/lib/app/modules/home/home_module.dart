import 'package:buscador_de_giphy/app/modules/gifpage/gifPage_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'homePage_widget.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => HomePageWidget()),
    ChildRoute('/gifPage',
        child: (context, args) => GifPageWidget(gifModel: args.data)),
  ];
}
