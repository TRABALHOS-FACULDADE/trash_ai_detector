import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.add(
      ChildRoute(
        'name',
        child: (_) => Container(),
      ),
    );
    super.routes(r);
  }
}
