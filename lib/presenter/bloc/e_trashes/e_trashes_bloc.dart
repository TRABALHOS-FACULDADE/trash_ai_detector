import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/models/e_trash.dart';
import '../../../domain/models/new_e_trash.dart';
import '../../../domain/usecases/get_all_e_trashes.dart';
import '../../../domain/usecases/insert_new_e_trash.dart';

part 'e_trashes_event.dart';
part 'e_trashes_state.dart';

class ETrashesBloc extends Bloc<ETrashesEvent, ETrashesState> {
  ETrashesBloc() : super(ETrashesInitialState()) {
    on<FetchAllETrashesEvent>(
      _fetchAllETrashes,
    );

    on<InsertNewETrashEvent>(
      _insertNewETrash,
    );
  }

  List<ETrash> _content = [];

  Future<void> _fetchAllETrashes(
    FetchAllETrashesEvent event,
    emit,
  ) async {
    emit(ETrashesLoadingState());

    emit(
      (await Modular.get<GetAllETrashes>().call()).fold(
        (exception) => ETrashesErrorState(
          exception.toString(),
        ),
        (eTrashes) {
          _content = eTrashes.trashes;

          return ETrashesSuccessState(
            eTrashes,
          );
        },
      ),
    );
  }

  Future<void> _insertNewETrash(
    InsertNewETrashEvent event,
    emit,
  ) async {
    emit(ETrashesLoadingState());

    emit(
      (await Modular.get<InsertNewETrash>().call(
        event.newETrash,
      ))
          .fold(
        (exception) => ETrashesErrorState(
          exception.toString(),
        ),
        (eTrash) {
          _content = [
            ..._content,
            eTrash,
          ];

          return ETrashesSuccessState(
            ETrashFetch(_content),
          );
        },
      ),
    );
  }
}