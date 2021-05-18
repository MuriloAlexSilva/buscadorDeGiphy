import 'package:buscador_de_giphy/app/modules/gifpage/gifPage_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GifPageModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/gifPage',
        child: (context, args) => GifPageWidget(
              gifModel: args.data,
            )),
  ];
}
