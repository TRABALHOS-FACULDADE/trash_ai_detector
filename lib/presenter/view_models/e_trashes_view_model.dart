import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/models/new_e_trash.dart';
import '../bloc/e_trashes/e_trashes_bloc.dart';

class ETrashesViewModel {
  final bloc = Modular.get<ETrashesBloc>();

  void fetchAllETrashes() {
    bloc.add(FetchAllETrashesEvent());
  }

  void insertNewETrash(NewETrash newETrash) {
    bloc.add(InsertNewETrashEvent(newETrash));
  }
}
