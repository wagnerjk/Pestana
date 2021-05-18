import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pestana_app/bloc/pessoa/pessoa_bloc.dart';
import 'package:pestana_app/bloc/veiculo/veiculo_bloc.dart' as vb;
import 'package:pestana_app/views/cadastra_exibe_morador.dart';
import 'package:pestana_app/views/widgets/item_pessoa.dart';

class ListaMoradores extends StatefulWidget {
  const ListaMoradores({Key key}) : super(key: key);

  @override
  _ListaMoradoresState createState() => _ListaMoradoresState();
}

class _ListaMoradoresState extends State<ListaMoradores> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PessoaBloc>(context).add(LoadingSuccesPessoaEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<PessoaBloc, PessoaState>(
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        elevation: 10,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: BlocProvider.of<PessoaBloc>(context),
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<vb.VeiculoBloc>(context),
                  ),
                ],
                child: CadastraExibeMorador(),
              );
            },
          ),
        ),
      ),
    );
  }

  _blocBuilder() {
    return BlocBuilder<PessoaBloc, PessoaState>(
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
                    itemCount: state.pessoa.length,
                    itemBuilder: (context, index) {
                      return ItemPessoa(
                        pessoa: state.pessoa[index],
                        onTapItem: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider.value(
                                    value: BlocProvider.of<PessoaBloc>(context),
                                  ),
                                  BlocProvider.value(
                                    value: BlocProvider.of<vb.VeiculoBloc>(
                                        context),
                                  ),
                                ],
                                child: CadastraExibeMorador(
                                  exibePessoa: state.pessoa[index],
                                ),
                              );
                            },
                          ),
                        ),
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
