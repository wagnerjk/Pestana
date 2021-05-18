import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pestana_app/data/model/vaga_model.dart';
import 'package:pestana_app/data/repository/vaga_repository.dart';

part 'vaga_event.dart';
part 'vaga_state.dart';

class VagaBloc extends Bloc<VagaEvent, VagaState> {
  final VagaRepository repository;
  VagaBloc(this.repository) : super(VagaInitial());

  VagaState get initialState => LoadingState();

  @override
  Stream<VagaState> mapEventToState(
    VagaEvent event,
  ) async* {
    LoadingState();
    if (event is LoadingSuccesVagaEvent) {
      yield* _mapVagasLoadedToState();
    }
  }

  Stream<VagaState> _mapVagasLoadedToState() async* {
    try {
      var vagas = (await this.repository.getAllVagas());
      yield LoadedSucessState(vagas);
    } catch (_) {
      yield ErrorState("Erro ao carregar dados");
    }
  }
}