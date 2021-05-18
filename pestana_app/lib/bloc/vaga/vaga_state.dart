part of 'vaga_bloc.dart';

@immutable
abstract class VagaState extends Equatable {
  const VagaState();
}

class VagaInitial extends VagaState {
  @override
  List<Object> get props => [];
}

class EmptyState extends VagaState {
  @override
  List<Object> get props => null;
}

class InitialState extends VagaState {
  const InitialState();

  @override
  List<Object> get props => [];
}

class LoadingState extends VagaState {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class LoadedSucessState extends VagaState {
  final List<Vaga> vaga;
  const LoadedSucessState(this.vaga);

  @override
  List<Object> get props => [vaga];
}

class ErrorState extends VagaState{
  final String message;
  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}