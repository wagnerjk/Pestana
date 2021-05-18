part of 'pessoa_bloc.dart';

@immutable
abstract class PessoaEvent extends Equatable {
  const PessoaEvent();
}

class LoadingSuccesPessoaEvent extends PessoaEvent {
  @override
  List<Object> get props => [];
}

class GetPessoaEvent extends PessoaEvent{
  final int id;
  const GetPessoaEvent(this.id);

  @override
  List<Object> get props => [];
}

class CreatePessoaEvent extends PessoaEvent {
  final Pessoa pessoa;
  const CreatePessoaEvent(this.pessoa);

  @override
  List<Object> get props => [pessoa];
}

class UpdatePessoaEvent extends PessoaEvent {
  final Pessoa pessoa;
  const UpdatePessoaEvent(this.pessoa);

  @override
  List<Object> get props => [pessoa];
}

class DeletePessoaEvent extends PessoaEvent {
  final Pessoa pessoa;
  const DeletePessoaEvent(this.pessoa);

  @override
  List<Object> get props => [pessoa];
}

class NetworkErrorEvent extends Error {}