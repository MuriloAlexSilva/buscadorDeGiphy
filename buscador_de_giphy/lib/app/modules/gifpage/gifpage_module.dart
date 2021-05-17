import 'package:flutter_modular/flutter_modular.dart';

import 'gif_page.dart';

class GifPageModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/gifPage',
        child: (context, args) => GifPage(
              gifModel: args.data,
            )),
  ];
}
