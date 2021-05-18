part of 'vaga_bloc.dart';

abstract class VagaEvent extends Equatable {
  const VagaEvent();
}

class LoadingSuccesVagaEvent extends VagaEvent {
  @override
  List<Object> get props => [];
}

class GetVagaEvent extends VagaEvent{
  final int id;
  const GetVagaEvent(this.id);

  @override
  List<Object> get props => [];
}

class NetworkErrorEvent extends Error {}