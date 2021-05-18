import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pestana_app/bloc/veiculo/veiculo_bloc.dart' as vb;
import 'package:pestana_app/data/model/veiculo_model.dart';
import 'package:pestana_app/views/widgets/elevatedbutton_customizado.dart';
import 'package:pestana_app/views/widgets/input_customizado.dart';

class CadastraExibeVeiculo extends StatefulWidget {
  final Veiculo exibeVeiculo;
  final int idPessoa;
  const CadastraExibeVeiculo({Key key, this.exibeVeiculo, this.idPessoa})
      : super(key: key);

  @override
  _CadastraExibeVeiculoState createState() => _CadastraExibeVeiculoState();
}

class _CadastraExibeVeiculoState extends State<CadastraExibeVeiculo> {
  Veiculo _veiculo = Veiculo();
  Veiculo _exibeVeiculo = Veiculo();
  final _formKey = GlobalKey<FormState>();
  FocusNode focusMarca;
  FocusNode focusModelo;
  FocusNode focusPlaca;
  FocusNode focusAno;
  TextEditingController _controllerMarca = TextEditingController();
  TextEditingController _controllerModelo = TextEditingController();
  TextEditingController _controllerPlaca = TextEditingController();
  TextEditingController _controllerAno = TextEditingController();

  _cadastraAlteraVeiculo() {
    _formKey.currentState.save();
    _veiculo.idPessoa = widget.idPessoa;

    if (_exibeVeiculo != null) {
      BlocProvider.of<vb.VeiculoBloc>(context)
          .add(vb.UpdateVeiculoEvent(_veiculo));
    } else {
      BlocProvider.of<vb.VeiculoBloc>(context)
          .add(vb.CreateVeiculoEvent(_veiculo));
    }

    Navigator.pop(context);
  }

  _carregaVeiculo() {
    if (_exibeVeiculo != null) {
      _veiculo.id = _exibeVeiculo.id;
      _veiculo.idPessoa = widget.idPessoa;
      _controllerMarca.text = _exibeVeiculo.marca;
      _controllerModelo.text = _exibeVeiculo.modelo;
      _controllerPlaca.text = _exibeVeiculo.placa.toUpperCase();
      _controllerAno.text = _exibeVeiculo.ano.toString();
    }
  }

  _deletaVeiculo() {
    BlocProvider.of<vb.VeiculoBloc>(context)
        .add(vb.DeleteVeiculoEvent(_veiculo));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    focusMarca = FocusNode();
    focusModelo = FocusNode();
    focusPlaca = FocusNode();
    focusAno = FocusNode();

    _exibeVeiculo = widget.exibeVeiculo;

    _carregaVeiculo();
  }

  @override
  void dispose() {
    _controllerMarca.dispose();
    _controllerModelo.dispose();
    _controllerPlaca.dispose();
    _controllerAno.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _exibeVeiculo == null ? 'Cadastrar veículo' : 'Alterar veículo'),
        actions: [
          if (_exibeVeiculo != null)
            Padding(
              padding: EdgeInsets.only(right: 6),
              child: IconButton(
                onPressed: () {
                  _deletaVeiculo();
                },
                icon: Icon(Icons.delete),
              ),
            )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 12, right: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 30),
              buildForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputCustomizado(
            label: 'Marca',
            controller: _controllerMarca,
            autofocus: _exibeVeiculo == null ? true : false,
            focusNode: focusMarca,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            validator: RequiredValidator(
              errorText: "Campo obrigatório",
            ),
            onSaved: (marca) {
              _veiculo.marca = marca;
            },
            onFieldSubmitted: (_) {
              focusMarca.unfocus();
              FocusScope.of(context).requestFocus(focusModelo);
            },
          ),
          SizedBox(height: 20),
          InputCustomizado(
            label: 'Modelo',
            controller: _controllerModelo,
            focusNode: focusModelo,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            validator: RequiredValidator(
              errorText: "Campo obrigatório",
            ),
            onSaved: (modelo) {
              _veiculo.modelo = modelo;
            },
            onFieldSubmitted: (_) {
              focusModelo.unfocus();
              FocusScope.of(context).requestFocus(focusPlaca);
            },
          ),
          SizedBox(height: 20),
          InputCustomizado(
            label: 'Placa',
            controller: _controllerPlaca,
            focusNode: focusPlaca,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.characters,
            validator: RequiredValidator(
              errorText: "Campo obrigatório",
            ),
            onSaved: (placa) {
              _veiculo.placa = placa.toUpperCase();
            },
            onFieldSubmitted: (_) {
              focusPlaca.unfocus();
              FocusScope.of(context).requestFocus(focusAno);
            },
          ),
          SizedBox(height: 20),
          InputCustomizado(
            label: 'Ano modelo',
            controller: _controllerAno,
            focusNode: focusAno,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            validator: RequiredValidator(
              errorText: "Campo obrigatório",
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onSaved: (ano) {
              _veiculo.ano = int.parse(ano);
            },
            onFieldSubmitted: (_) {
              focusAno.unfocus();
            },
          ),
          SizedBox(height: 30),
          ElevatedButtonCustomizado(
            text: _exibeVeiculo == null ? 'Cadastrar' : 'Alterar dados',
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _cadastraAlteraVeiculo();
              }
            },
          ),
        ],
      ),
    );
  }
}
