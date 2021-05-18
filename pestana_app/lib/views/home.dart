import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pestana_app/views/pagetabs/lista_dados_vagas.dart';
import 'package:pestana_app/views/pagetabs/lista_moradores.dart';
import 'package:pestana_app/views/pagetabs/lista_veiculos.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indexAtual = 0;
  final List<Widget> _telas = [
    ListaMoradores(),
    ListaVeiculos(),
    ListaDadosVagas(),
  ];

  void _onTabTapped(int index) {
    setState(
      () {
        _indexAtual = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pestana'),
      ),
      body: _telas[_indexAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indexAtual,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(MaterialCommunityIcons.account_group),
            label: 'Moradores',
          ),
          BottomNavigationBarItem(
            icon: Icon(MaterialCommunityIcons.car_multiple),
            label: 'Veículos',
          ),
          BottomNavigationBarItem(
            icon: Icon(MaterialCommunityIcons.garage),
            label: 'Vagas',
          ),
        ],
      ),
    );
  }
}
