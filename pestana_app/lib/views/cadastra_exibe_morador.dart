import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:pestana_app/bloc/pessoa/pessoa_bloc.dart';
import 'package:pestana_app/bloc/veiculo/veiculo_bloc.dart' as vb;
import 'package:pestana_app/data/model/pessoa_model.dart';
import 'package:pestana_app/helpers/formata_cpf.dart';
import 'package:pestana_app/views/cadastra_exibe_veiculo.dart';
import 'package:pestana_app/views/widgets/elevatedbutton_customizado.dart';
import 'package:pestana_app/views/widgets/input_customizado.dart';
import 'package:pestana_app/views/widgets/list_tile_veiculo.dart';

class CadastraExibeMorador extends StatefulWidget {
  final Pessoa exibePessoa;
  const CadastraExibeMorador({Key key, this.exibePessoa}) : super(key: key);

  @override
  _CadastraExibeMoradorState createState() => _CadastraExibeMoradorState();
}

class _CadastraExibeMoradorState extends State<CadastraExibeMorador> {
  Pessoa _pessoa = Pessoa();
  Pessoa _exibePessoa = Pessoa();
  final _formKey = GlobalKey<FormState>();
  FocusNode focusNome;
  FocusNode focusCpf;
  FocusNode focusApartamento;
  FocusNode focusDataNascimento;
  FocusNode focusTelefone;
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerCpf = TextEditingController();
  TextEditingController _controllerApartamento = TextEditingController();
  TextEditingController _controllerDataNascimento = TextEditingController();
  TextEditingController _controllerTelefone = TextEditingController();

  final cpfValidator = MultiValidator([
    RequiredValidator(errorText: "Campo obrigatório"),
    MinLengthValidator(14, errorText: "Informe um CPF válido"),
  ]);

  final dataValidator = MultiValidator([
    RequiredValidator(errorText: "Campo obrigatório"),
    MinLengthValidator(10, errorText: "Informe uma data válida"),
  ]);

  final telefoneValidator = MultiValidator([
    RequiredValidator(errorText: "Campo obrigatório"),
    MinLengthValidator(15, errorText: "Informe um telefone válido"),
  ]);

  _cadastraAlteraPessoa() {
    _formKey.currentState.save();

    if (_exibePessoa != null) {
      BlocProvider.of<PessoaBloc>(context).add(UpdatePessoaEvent(_pessoa));
    } else {
      BlocProvider.of<PessoaBloc>(context).add(CreatePessoaEvent(_pessoa));
    }

    Navigator.pop(context);
  }

  _carregaPessoa() {
    if (_exibePessoa != null) {
      _pessoa.id = _exibePessoa.id;
      _controllerNome.text = _exibePessoa.nome;
      _controllerCpf.text = FormataCpf.formatCPF(_exibePessoa.cpf);
      _controllerApartamento.text = _exibePessoa.apartamento.toString();
      _controllerDataNascimento.text = UtilData.obterDataDDMMAAAA(
          DateFormat("yyyy/MM/dd")
              .parse(_exibePessoa.dataNascimento.replaceAll("-", "/")));
      _controllerTelefone.text =
          UtilBrasilFields.obterTelefone(_exibePessoa.telefone);
    }
  }

  _deletaPessoa() {
    BlocProvider.of<PessoaBloc>(context).add(DeletePessoaEvent(_pessoa));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    focusNome = FocusNode();
    focusCpf = FocusNode();
    focusApartamento = FocusNode();
    focusDataNascimento = FocusNode();
    focusTelefone = FocusNode();

    _exibePessoa = widget.exibePessoa;

    _carregaPessoa();

    BlocProvider.of<PessoaBloc>(context).add(LoadingSuccesPessoaEvent());
    BlocProvider.of<vb.VeiculoBloc>(context)
        .add(vb.GetAllVeiculosByPessoaEvent(_exibePessoa));
  }

  @override
  void dispose() {
    _controllerNome.dispose();
    _controllerCpf.dispose();
    _controllerApartamento.dispose();
    _controllerDataNascimento.dispose();
    _controllerTelefone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _exibePessoa == null ? 'Cadastrar morador' : 'Alterar morador'),
        actions: [
          if (_exibePessoa != null)
            Padding(
              padding: EdgeInsets.only(right: 6),
              child: IconButton(
                onPressed: () {
                  _deletaPessoa();
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
              _exibePessoa != null ? buildListVeiculos() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Column buildListVeiculos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16),
        ElevatedButtonCustomizado(
          text: 'Adicionar veículo',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return BlocProvider.value(
                  value: BlocProvider.of<vb.VeiculoBloc>(
                      context),
                  child: CadastraExibeVeiculo(
                    idPessoa: _exibePessoa.id,
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 30),
        Text(
          'Veículos de ${_exibePessoa.nome}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 10),
        BlocBuilder<vb.VeiculoBloc, vb.VeiculoState>(
          builder: (context, state) {
            if (state is vb.LoadedSucessState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.veiculo.length,
                    itemBuilder: (context, index) {
                      return ListTileVeiculo(
                        texto: state.veiculo[index].modelo,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return BlocProvider.value(
                                value: BlocProvider.of<vb.VeiculoBloc>(
                                    context),
                                child: CadastraExibeVeiculo(
                                  exibeVeiculo: state.veiculo[index],
                                  idPessoa: _exibePessoa.id,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return Container();
          },
        )
      ],
    );
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputCustomizado(
            label: 'Nome',
            controller: _controllerNome,
            autofocus: _exibePessoa == null ? true : false,
            focusNode: focusNome,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            validator: RequiredValidator(
              errorText: "Campo obrigatório",
            ),
            onSaved: (nome) {
              _pessoa.nome = nome;
            },
            onFieldSubmitted: (_) {
              focusNome.unfocus();
              FocusScope.of(context).requestFocus(focusCpf);
            },
          ),
          SizedBox(height: 20),
          InputCustomizado(
            label: 'CPF',
            controller: _controllerCpf,
            focusNode: focusCpf,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: cpfValidator,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CpfInputFormatter(),
            ],
            onSaved: (cpf) {
              if (cpf.length == 14) {
                _pessoa.cpf =
                    cpf.replaceAll(".", "").replaceAll("-", "").trim();
              }
            },
            onFieldSubmitted: (_) {
              focusCpf.unfocus();
              FocusScope.of(context).requestFocus(focusApartamento);
            },
          ),
          SizedBox(height: 20),
          InputCustomizado(
            label: 'Apartamento',
            controller: _controllerApartamento,
            focusNode: focusApartamento,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: RequiredValidator(
              errorText: "Campo obrigatório",
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onSaved: (apartamento) {
              _pessoa.apartamento = int.parse(apartamento);
            },
            onFieldSubmitted: (_) {
              focusApartamento.unfocus();
              FocusScope.of(context).requestFocus(focusDataNascimento);
            },
          ),
          SizedBox(height: 20),
          InputCustomizado(
            label: 'Data de nascimento',
            controller: _controllerDataNascimento,
            focusNode: focusDataNascimento,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: dataValidator,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              DataInputFormatter(),
            ],
            onSaved: (data) {
              _pessoa.dataNascimento = DateFormat('yyyy-MM-dd').format(
                  DateFormat('dd-MM-yyyy').parse(data.replaceAll("/", "-")));
            },
            onFieldSubmitted: (_) {
              focusDataNascimento.unfocus();
              FocusScope.of(context).requestFocus(focusTelefone);
            },
          ),
          SizedBox(height: 20),
          InputCustomizado(
            label: 'Telefone',
            controller: _controllerTelefone,
            focusNode: focusTelefone,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            validator: telefoneValidator,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TelefoneInputFormatter(),
            ],
            onSaved: (telefone) {
              _pessoa.telefone = telefone
                  .replaceAll("(", "")
                  .replaceAll(")", "")
                  .replaceAll("-", "")
                  .replaceAll(" ", "")
                  .trim();
            },
            onFieldSubmitted: (_) {
              focusTelefone.unfocus();
            },
          ),
          SizedBox(height: 30),
          ElevatedButtonCustomizado(
            text: _exibePessoa == null ? 'Cadastrar' : 'Alterar dados',
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _cadastraAlteraPessoa();
              }
            },
          ),
        ],
      ),
    );
  }
}
