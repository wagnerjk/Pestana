part of 'pessoa_bloc.dart';

@immutable
abstract class PessoaState extends Equatable {
  const PessoaState();
}

class PessoaInitial extends PessoaState {
  @override
  List<Object> get props => [];
}

class EmptyState extends PessoaState {
  @override
  List<Object> get props => null;
}

class InitialState extends PessoaState {
  const InitialState();

  @override
  List<Object> get props => [];
}

class LoadingState extends PessoaState {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class LoadedSucessState extends PessoaState {
  final List<Pessoa> pessoa;
  const LoadedSucessState(this.pessoa);

  @override
  List<Object> get props => [pessoa];
}

class ErrorState extends PessoaState{
  final String message;
  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}