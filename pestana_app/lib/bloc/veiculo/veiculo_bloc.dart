import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pestana_app/data/model/pessoa_model.dart';
import 'package:pestana_app/data/model/veiculo_model.dart';
import 'package:pestana_app/data/repository/veiculo_repository.dart';

part 'veiculo_event.dart';
part 'veiculo_state.dart';

class VeiculoBloc extends Bloc<VeiculoEvent, VeiculoState> {
  final VeiculoRepository repository;
  VeiculoBloc(this.repository) : super(VeiculoInitial());

  VeiculoState get initialState => LoadingState();

  @override
  Stream<VeiculoState> mapEventToState(
    VeiculoEvent event,
  ) async* {
    LoadingState();
    if (event is LoadingSuccesVeiculoEvent) {
      yield* _mapVeiculosLoadedToState();
    } else if (event is GetAllVeiculosByPessoaEvent) {
      yield* _mapVeiculosPessoasToState(event);
    } else if (event is CreateVeiculoEvent) {
      yield* _mapVeiculoAddedToState(event);
    } else if (event is UpdateVeiculoEvent) {
      yield* _mapVeiculoUpdatedToState(event);
    } else if (event is DeleteVeiculoEvent) {
      yield* _mapVeiculosDeletedToState(event);
    }
  }

  Stream<VeiculoState> _mapVeiculosLoadedToState() async* {
    try {
      var veiculos = (await this.repository.getAllVeiculos());
      yield LoadedSucessState(veiculos);
    } catch (_) {
      yield ErrorState("Erro ao carregar dados");
    }
  }

  Stream<VeiculoState> _mapVeiculosPessoasToState(
      GetAllVeiculosByPessoaEvent event) async* {
    try {
      var veiculos = (await this
          .repository
          .getAllVeiculosByPessoa(event.pessoa.id));
      yield LoadedSucessState(veiculos);
    } catch (_) {
      yield ErrorState("Erro ao carregar dados");
    }
  }

  Stream<VeiculoState> _mapVeiculoAddedToState(
      CreateVeiculoEvent event) async* {
    try {
      if (state is LoadedSucessState) {
        var novaVeiculo = (await this.repository.createVeiculo(event.veiculo));
        List<Veiculo> updatedVeiculos;
        if (novaVeiculo != null) {
          updatedVeiculos = List.from((state as LoadedSucessState).veiculo)
            ..add(novaVeiculo);
          yield LoadedSucessState(updatedVeiculos.reversed.toList());
        }
      }
    } catch (_) {
      yield ErrorState("Erro ao adicionar morador");
    }
  }

  Stream<VeiculoState> _mapVeiculoUpdatedToState(
      UpdateVeiculoEvent event) async* {
    try {
      if (state is LoadedSucessState) {
        var updatedVeiculo =
            (await this.repository.updateVeiculo(event.veiculo));
        if (updatedVeiculo != null) {
          final List<Veiculo> updatedVeiculos =
              (state as LoadedSucessState).veiculo.map((veiculo) {
            return veiculo.id == updatedVeiculo.id ? updatedVeiculo : veiculo;
          }).toList();
          yield LoadedSucessState(updatedVeiculos);
        }
      }
    } catch (_) {
      yield ErrorState("Erro ao adicionar morador");
    }
  }

  Stream<VeiculoState> _mapVeiculosDeletedToState(
      DeleteVeiculoEvent event) async* {
    try {
      if (state is LoadedSucessState) {
        await this.repository.deleteVeiculo(event.veiculo.id);
        final List<Veiculo> deleteVeiculo = (state as LoadedSucessState)
            .veiculo
            .where((element) => element.id != event.veiculo.id)
            .toList();
        yield LoadedSucessState(deleteVeiculo);
      }
    } catch (_) {
      yield ErrorState("Erro ao excluir morador");
    }
  }
}
