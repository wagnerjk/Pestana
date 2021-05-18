import 'package:equatable/equatable.dart';

class Veiculo extends Equatable {
  int id;
  int idPessoa;
  String marca;
  String modelo;
  String placa;
  int ano;

  Veiculo(
      {this.id, this.idPessoa, this.marca, this.modelo, this.placa, this.ano});

  factory Veiculo.fromJson(Map<String, dynamic> json){
    return Veiculo(
      id: json['id'],
      idPessoa: json['idPessoa'],
      marca: json['marca'],
      modelo: json['modelo'],
      placa: json['placa'],
      ano: json['ano'],
    );
  }

  @override
  List<Object> get props => [
    id,
    idPessoa,
    marca,
    modelo,
    placa,
    ano,
  ];
}
