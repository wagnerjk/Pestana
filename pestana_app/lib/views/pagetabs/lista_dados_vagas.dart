import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pestana_app/bloc/vaga/vaga_bloc.dart';
import 'package:pestana_app/views/widgets/item_vagas.dart';

class ListaDadosVagas extends StatefulWidget {
  const ListaDadosVagas({Key key}) : super(key: key);

  @override
  _ListaDadosVagasState createState() => _ListaDadosVagasState();
}

class _ListaDadosVagasState extends State<ListaDadosVagas> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VagaBloc>(context).add(LoadingSuccesVagaEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<VagaBloc, VagaState>(
          listener: (context, state) {
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: _blocBuilder(),
        ),
      ),
    );
  }

  _blocBuilder() {
    return BlocBuilder<VagaBloc, VagaState>(
      builder: (context, state) {
        if (state is InitialState) {
          return Center(
            child: Text("Initial"),
          );
        } else if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadedSucessState) {
          return Container(
            margin: EdgeInsets.only(left: 6, right: 6),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: state.vaga.length,
                    itemBuilder: (context, index) {
                      return ItemVaga(
                        vaga: state.vaga[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is ErrorState) {
          return Center(
            child: Text("Erro ao carregar dados."),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sem dados!',
              ),
            ],
          ),
        );
      },
    );
  }
}
