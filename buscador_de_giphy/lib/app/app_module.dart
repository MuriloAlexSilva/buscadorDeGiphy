import 'package:buscador_de_giphy/app/modules/gifpage/gifPage_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute(Modular.initialRoute, module: GifPageModule()),
  ];
}
