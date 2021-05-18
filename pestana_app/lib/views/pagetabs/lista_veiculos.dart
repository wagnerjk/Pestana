import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pestana_app/bloc/veiculo/veiculo_bloc.dart';
import 'package:pestana_app/views/widgets/item_veiculo.dart';

class ListaVeiculos extends StatefulWidget {
  const ListaVeiculos({Key key}) : super(key: key);

  @override
  _ListaVeiculosState createState() => _ListaVeiculosState();
}

class _ListaVeiculosState extends State<ListaVeiculos> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<VeiculoBloc>(context).add(LoadingSuccesVeiculoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<VeiculoBloc, VeiculoState>(
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
    return BlocBuilder<VeiculoBloc, VeiculoState>(
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
                    itemCount: state.veiculo.length,
                    itemBuilder: (context, index) {
                      return ItemVeiculo(
                        veiculo: state.veiculo[index],
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
