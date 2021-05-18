import 'package:equatable/equatable.dart';

class Pessoa extends Equatable {
  int id;
  String nome;
  String cpf;
  int apartamento;
  String dataNascimento;
  String telefone;

  Pessoa(
      {this.id,
      this.nome,
      this.cpf,
      this.apartamento,
      this.dataNascimento,
      this.telefone});

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      apartamento: json['apartamento'],
      dataNascimento: json['dataNascimento'],
      telefone: json['telefone'],
    );
  }

  @override
  List<Object> get props => [
        id,
        nome,
        cpf,
        apartamento,
        dataNascimento,
        telefone,
      ];
}
