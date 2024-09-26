part of 'e_trashes_bloc.dart';

abstract class ETrashesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllETrashesEvent extends ETrashesEvent {}

class InsertNewETrashEvent extends ETrashesEvent {
  final NewETrash newETrash;

  InsertNewETrashEvent(this.newETrash);
}
