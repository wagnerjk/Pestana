import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pestana_app/data/model/veiculo_model.dart';

abstract class VeiculoRepository {
  Future<List<Veiculo>> getAllVeiculos();
  Future<List<Veiculo>> getAllVeiculosByPessoa(int id);
  Future<Veiculo> getVeiculo(int id);
  Future<Veiculo> createVeiculo(veiculo);
  Future<Veiculo> updateVeiculo(veiculo);
  Future<Veiculo> deleteVeiculo(int id);
}

const API_URL_BASE = 'http://192.168.3.13:8080/veiculo';
const Map<String, String> API_HEADERS = {
  'content-type': 'application/json; charset=utf-8'
};

class VeiculoRepositoryImpl implements VeiculoRepository {
  @override
  Future<List<Veiculo>> getAllVeiculos() async {
    var response;
    try {
      response = await http.get(Uri.parse(API_URL_BASE));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => Veiculo.fromJson(i))
            .toList();
      } else {
        throw Exception('Erro ao carregar dados');
      }
    } catch (error) {
      throw Exception('Erro ao carregar dados' + error.toString());
    }
  }

  Future<List<Veiculo>> getAllVeiculosByPessoa(int id) async {
    var response;
    try {
      response = await http.get(Uri.parse('$API_URL_BASE/pessoa/$id'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => Veiculo.fromJson(i))
            .toList();
      } else {
        throw Exception('Erro ao carregar dados');
      }
    } catch (error) {
      throw Exception('Erro ao carregar dados' + error.toString());
    }
  }

  @override
  Future<Veiculo> getVeiculo(int id) async {
    try {
      if (id != null) {
        final response = await http.get(Uri.http(API_URL_BASE, "/$id"));
        if (response.statusCode == 200) {
          return Veiculo.fromJson(json.decode(response.body));
        } else {
          throw Exception('Erro ao carregar dados');
        }
      }
    } catch (error) {
      throw Exception('Erro ao carregar dados' + error.toString());
    }
    return null;
  }

  @override
  Future<Veiculo> createVeiculo(veiculo) async {
    try {
      if (veiculo != null) {
        final response = await http.post(
          Uri.parse(API_URL_BASE),
          headers: API_HEADERS,
          body: jsonEncode(<String, dynamic>{
            'idPessoa' : veiculo.idPessoa,
            'marca'    : veiculo.marca,
            'modelo'   : veiculo.modelo,
            'placa'    : veiculo.placa,
            'ano'      : veiculo.ano,
          }),
        );
        if (response.statusCode == 200) {
          return Veiculo.fromJson(json.decode(response.body));
        } else {
          throw Exception('Erro ao registrar veículo');
        }
      }
    } catch (error) {
      throw Exception('Erro ao registrar veículo ' + error);
    }
    return null;
  }

  @override
  Future<Veiculo> updateVeiculo(veiculo) async {
    try {
      if (veiculo != null) {
        final response = await http.put(
          Uri.parse('$API_URL_BASE/${veiculo.id}'),
          headers: API_HEADERS,
          body: jsonEncode(<String, dynamic>{
            'idPessoa' : veiculo.idPessoa,
            'marca'    : veiculo.marca,
            'modelo'   : veiculo.modelo,
            'placa'    : veiculo.placa,
            'ano'      : veiculo.ano,
          }),
        );
        if (response.statusCode == 200) {
          return Veiculo.fromJson(json.decode(response.body));
        } else {
          throw Exception('Erro ao carregar dados');
        }
      }
    } catch (error) {
      throw Exception('Erro ao alterar veículo ' + error.toString());
    }
    return null;
  }

  @override
  Future<Veiculo> deleteVeiculo(int id) async {
    try {
      if (id != null) {
        final response = await http.delete(
          Uri.parse('$API_URL_BASE/$id'),
          headers: API_HEADERS,
        );
        if (response.statusCode == 200) {
          //return Veiculo.fromJson(json.decode(response.body));
        } else {
          throw Exception('Erro ao carregar dados');
        }
      }
    } catch (error) {
      throw Exception('Erro ao excluir veículo ' + error.toString());
    }
    return null;
  }
}
