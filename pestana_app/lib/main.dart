import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pestana_app/bloc/pessoa/pessoa_bloc.dart';
import 'package:pestana_app/bloc/vaga/vaga_bloc.dart';
import 'package:pestana_app/bloc/veiculo/veiculo_bloc.dart';
import 'package:pestana_app/data/repository/pessoa_repository.dart';
import 'package:pestana_app/data/repository/veiculo_repository.dart';
import 'package:pestana_app/views/home.dart';
import 'package:pestana_app/views/pagetabs/lista_moradores.dart';

import 'data/repository/vaga_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pestana',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.varelaTextTheme(
            Theme.of(context).textTheme,
        )
      ),
      home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (BuildContext context) => PessoaBloc(PessoaRepositoryImpl()),
            ),
            BlocProvider(
              create: (BuildContext context) => VeiculoBloc(VeiculoRepositoryImpl()),
            ),
            BlocProvider(
              create: (BuildContext context) => VagaBloc(VagaRepositoryImpl()),
            ),
          ],
          child: Home()),
      /*
      home: BlocProvider(
        create: (BuildContext context) => PessoaBloc(PessoaRepositoryImpl()),
        child: Home(),
      ),

       */
    );
  }
}