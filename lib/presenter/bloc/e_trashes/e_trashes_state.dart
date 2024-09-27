part of 'e_trashes_bloc.dart';

abstract class ETrashesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ETrashesInitialState extends ETrashesState {}

class ETrashesLoadingState extends ETrashesState {}

class ETrashesSuccessState extends ETrashesState {
  final ETrashFetch eTrashes;

  ETrashesSuccessState(this.eTrashes);
}

class ETrashesErrorState extends ETrashesState {
  final String message;

  ETrashesErrorState(this.message);
}
