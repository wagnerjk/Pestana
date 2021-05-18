import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pestana_app/data/model/vaga_model.dart';

abstract class VagaRepository {
  Future<List<Vaga>> getAllVagas();
  Future<Vaga> getVaga(int id);
}

const API_URL_BASE = 'http://192.168.3.13:8080/vaga';
const Map<String, String> API_HEADERS = {
  'content-type': 'application/json; charset=utf-8'
};

class VagaRepositoryImpl implements VagaRepository {
  @override
  Future<List<Vaga>> getAllVagas() async {
    try {
      final response = await http.get(Uri.parse(API_URL_BASE));
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => Vaga.fromJson(i))
            .toList();
      } else {
        throw Exception('Erro ao carregar dados');
      }
    } catch (error) {
      throw Exception('Erro ao carregar dados' + error.toString());
    }
  }

  @override
  Future<Vaga> getVaga(int id) async {
    try {
      if (id != null) {
        final response = await http.get(Uri.http(API_URL_BASE, "/$id"));
        if (response.statusCode == 200) {
          return Vaga.fromJson(json.decode(response.body));
        } else {
          throw Exception('Erro ao carregar dados');
        }
      }
    } catch (error) {
      throw Exception('Erro ao carregar dados' + error.toString());
    }
    return null;
  }

}
