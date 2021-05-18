part of 'veiculo_bloc.dart';

@immutable
abstract class VeiculoState extends Equatable {
  const VeiculoState();
}

class VeiculoInitial extends VeiculoState {
  @override
  List<Object> get props => [];
}

class EmptyState extends VeiculoState {
  @override
  List<Object> get props => null;
}

class InitialState extends VeiculoState {
  const InitialState();

  @override
  List<Object> get props => [];
}

class LoadingState extends VeiculoState {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class LoadedSucessState extends VeiculoState {
  final List<Veiculo> veiculo;
  const LoadedSucessState(this.veiculo);

  @override
  List<Object> get props => [veiculo];
}

class ErrorState extends VeiculoState{
  final String message;
  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}