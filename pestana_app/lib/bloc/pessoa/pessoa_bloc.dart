import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pestana_app/data/model/pessoa_model.dart';
import 'package:pestana_app/data/repository/pessoa_repository.dart';

part 'pessoa_event.dart';
part 'pessoa_state.dart';

class PessoaBloc extends Bloc<PessoaEvent, PessoaState> {
  final PessoaRepository repository;
  PessoaBloc(this.repository) : super(PessoaInitial());

  PessoaState get initialState => LoadingState();

  @override
  Stream<PessoaState> mapEventToState(
    PessoaEvent event,
  ) async* {
    LoadingState();
    if (event is LoadingSuccesPessoaEvent) {
      yield* _mapPessoasLoadedToState();
    } else if (event is CreatePessoaEvent) {
      yield* _mapPessoaAddedToState(event);
    } else if (event is UpdatePessoaEvent) {
      yield* _mapPessoaUpdatedToState(event);
    } else if (event is DeletePessoaEvent) {
      yield* _mapPessoasDeletedToState(event);
    }
  }

  Stream<PessoaState> _mapPessoasLoadedToState() async* {
    try {
      var pessoas = (await this.repository.getAllPessoas());
      yield LoadedSucessState(pessoas);
    } catch (_) {
      yield ErrorState("Erro ao carregar dados");
    }
  }

  Stream<PessoaState> _mapPessoaAddedToState(CreatePessoaEvent event) async* {
    try {
      if (state is LoadedSucessState) {
        var novaPessoa = (await this.repository.createPessoa(event.pessoa));
        List<Pessoa> updatedPessoas;
        if (novaPessoa != null) {
          updatedPessoas = List.from((state as LoadedSucessState).pessoa)
            ..add(novaPessoa);
          yield LoadedSucessState(updatedPessoas.reversed.toList());
        }
      }
    } catch (_) {
      yield ErrorState("Erro ao adicionar morador");
    }
  }

  Stream<PessoaState> _mapPessoaUpdatedToState(UpdatePessoaEvent event) async* {
    try {
      if (state is LoadedSucessState) {
        var updatedPessoa = (await this.repository.updatePessoa(event.pessoa));
        if (updatedPessoa != null) {
          final List<Pessoa> updatedPessoas =
              (state as LoadedSucessState).pessoa.map((pessoa) {
            return pessoa.id == updatedPessoa.id ? updatedPessoa : pessoa;
          }).toList();
          yield LoadedSucessState(updatedPessoas);
        }
      }
    } catch (_) {
      yield ErrorState("Erro ao adicionar morador");
    }
  }

  Stream<PessoaState> _mapPessoasDeletedToState(DeletePessoaEvent event) async* {
    try {
      if (state is LoadedSucessState) {
        await this.repository.deletePessoa(event.pessoa.id);
        final List<Pessoa> deletePessoa = (state as LoadedSucessState)
            .pessoa
            .where((element) => element.id != event.pessoa.id)
            .toList();
        yield LoadedSucessState(deletePessoa);
      }
    } catch (_) {
      yield ErrorState("Erro ao excluir morador");
    }
  }
}