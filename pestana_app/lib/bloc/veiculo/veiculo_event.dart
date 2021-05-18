part of 'veiculo_bloc.dart';

abstract class VeiculoEvent extends Equatable {
  const VeiculoEvent();
}


class LoadingSuccesVeiculoEvent extends VeiculoEvent {
  @override
  List<Object> get props => [];
}

class GetVeiculoEvent extends VeiculoEvent{
  final int id;
  const GetVeiculoEvent(this.id);

  @override
  List<Object> get props => [];
}

class GetAllVeiculosByPessoaEvent extends VeiculoEvent{
  final Pessoa pessoa;
  const GetAllVeiculosByPessoaEvent(this.pessoa);

  @override
  List<Object> get props => [];
}

class CreateVeiculoEvent extends VeiculoEvent {
  final Veiculo veiculo;
  const CreateVeiculoEvent(this.veiculo);

  @override
  List<Object> get props => [veiculo];
}

class UpdateVeiculoEvent extends VeiculoEvent {
  final Veiculo veiculo;
  const UpdateVeiculoEvent(this.veiculo);

  @override
  List<Object> get props => [veiculo];
}

class DeleteVeiculoEvent extends VeiculoEvent {
  final Veiculo veiculo;
  const DeleteVeiculoEvent(this.veiculo);

  @override
  List<Object> get props => [veiculo];
}

class NetworkErrorEvent extends Error {}
