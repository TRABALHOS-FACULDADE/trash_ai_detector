import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../external/datasources/e_trash_datasource_impl.dart';
import '../../home.dart';
import '../../infra/datasources/e_trash_datasource.dart';
import '../../infra/repositories/e_trash_repository_impl.dart';
import '../../presenter/view_models/tflite_view_model.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.add<TFLiteViewModel>(TFLiteViewModel.new);
    i.add<Supabase>(
      (_) => Supabase.instance,
    );
    i.add(
      (_) => ETrashDatasourceImpl(
        i.get<Supabase>(),
      ),
    );
    i.add(
      (_) => ETrashRepositoryImpl(
        i.get<ETrashDatasource>(),
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.add(
      ChildRoute(
        '/',
        child: (_) => const HomePage(),
      ),
    );
    super.routes(r);
  }
}