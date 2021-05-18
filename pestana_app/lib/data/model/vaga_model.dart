import 'package:equatable/equatable.dart';

class Vaga extends Equatable {
  int id;
  int idVeiculo;

  Vaga({
    this.id,
    this.idVeiculo,
  });

  factory Vaga.fromJson(Map<String, dynamic> json) {
    return Vaga(
      id: json["id"],
      idVeiculo: json["idVeiculo"],
    );
  }

  @override
  List<Object> get props => [
        id,
        idVeiculo,
      ];
}
