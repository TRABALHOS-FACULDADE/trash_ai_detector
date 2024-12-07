import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/repositories/e_trash_repository.dart';
import '../../domain/usecases/delete_e_trash.dart';
import '../../domain/usecases/delete_trash_file.dart';
import '../../domain/usecases/get_all_e_trashes.dart';
import '../../domain/usecases/insert_new_e_trash.dart';
import '../../domain/usecases/upload_trash_file.dart';
import '../../external/datasources/e_trash_datasource_impl.dart';
import '../../infra/datasources/e_trash_datasource.dart';
import '../../infra/repositories/e_trash_repository_impl.dart';
import '../../presenter/bloc/e_trashes/e_trashes_bloc.dart';
import '../../presenter/pages/e_trash_monitoring_page.dart';
import '../../presenter/pages/home.dart';
import '../../presenter/view_models/e_trashes_view_model.dart';
import '../../presenter/view_models/tflite_view_model.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<TFLiteViewModel>(
      TFLiteViewModel.new,
    );

    i.addSingleton<ETrashDatasource>(
      ETrashDatasourceImpl.new,
    );

    i.addSingleton<ETrashRepository>(
      ETrashRepositoryImpl.new,
    );

    i.addSingleton<UploadTrashFile>(
      UploadTrashFileImpl.new,
    );

    i.addSingleton<InsertNewETrash>(
      InsertNewETrashImpl.new,
    );

    i.addSingleton<GetAllETrashes>(
      GetAllETrashesImpl.new,
    );

    i.addSingleton<DeleteTrashFile>(
      DeleteTrashFileImpl.new,
    );

    i.addSingleton<DeleteETrash>(
      DeleteETrashImpl.new,
    );

    i.addSingleton<ETrashesViewModel>(
      ETrashesViewModel.new,
    );

    i.addSingleton<ETrashesBloc>(
      ETrashesBloc.new,
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

    r.add(
      ChildRoute(
        '/monitoring',
        child: (_) => ETrashMonitoringPage(
          eTrash: r.args.data,
        ),
      ),
    );
    super.routes(r);
  }
}
