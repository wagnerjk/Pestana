import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pestana_app/data/model/pessoa_model.dart';

abstract class PessoaRepository {
  Future<List<Pessoa>> getAllPessoas();
  Future<Pessoa> getPessoa(int id);
  Future<Pessoa> createPessoa(pessoa);
  Future<Pessoa> updatePessoa(pessoa);
  Future<Pessoa> deletePessoa(int id);
}

const API_URL_BASE = 'http://192.168.3.13:8080/pessoa';
const Map<String, String> API_HEADERS = {
  'content-type': 'application/json; charset=utf-8'
};

class PessoaRepositoryImpl implements PessoaRepository {
  @override
  Future<List<Pessoa>> getAllPessoas() async {
    try {
      final response = await http.get(Uri.parse(API_URL_BASE));
      if (response.statusCode == 200) {
        return (json.decode(response.body) as List)
            .map((i) => Pessoa.fromJson(i))
            .toList();
      } else {
        throw Exception('Erro ao carregar dados');
      }
    } catch (error) {
      throw Exception('Erro ao carregar dados' + error.toString());
    }
  }

  @override
  Future<Pessoa> getPessoa(int id) async {
    try {
      if (id != null) {
        final response = await http.get(Uri.http(API_URL_BASE, "/$id"));
        if (response.statusCode == 200) {
          return Pessoa.fromJson(json.decode(response.body));
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
  Future<Pessoa> createPessoa(pessoa) async {
    try {
      if (pessoa != null) {
        final response = await http.post(
          Uri.parse(API_URL_BASE),
          headers: API_HEADERS,
          body: jsonEncode(<String, dynamic>{
            'nome'           : pessoa.nome,
            'cpf'            : pessoa.cpf,
            'apartamento'    : pessoa.apartamento,
            'dataNascimento' : pessoa.dataNascimento,
            'telefone'       : pessoa.telefone,
          }),
        );
        if (response.statusCode == 200) {
          return Pessoa.fromJson(json.decode(response.body));
        } else {
          throw Exception('Erro ao registrar morador ');
        }
      }
    } catch (error) {
      throw Exception('Erro ao registrar morador ' + error.toString());
    }
    return null;
  }

  @override
  Future<Pessoa> updatePessoa(pessoa) async {
    try {
      if (pessoa != null) {
        final response = await http.put(
          Uri.parse('$API_URL_BASE/${pessoa.id}'),
          headers: API_HEADERS,
          body: jsonEncode(<String, dynamic>{
            'nome'           : pessoa.nome,
            'cpf'            : pessoa.cpf,
            'apartamento'    : pessoa.apartamento,
            'dataNascimento' : pessoa.dataNascimento,
            'telefone'       : pessoa.telefone,
          }),
        );
        if (response.statusCode == 200) {
          return Pessoa.fromJson(json.decode(response.body));
        } else {
          throw Exception('Erro ao carregar dados');
        }
      }
    } catch (error) {
      throw Exception('Erro ao alterar morador ' + error.toString());
    }
    return null;
  }

  @override
  Future<Pessoa> deletePessoa(int id) async {
    try {
      if (id != null) {
        final response = await http.delete(
          Uri.parse('$API_URL_BASE/$id'),
          headers: API_HEADERS,
        );
        if (response.statusCode == 200) {
          //return Pessoa.fromJson(json.decode(response.body));
        } else {
          throw Exception('Erro ao carregar dados');
        }
      }
    } catch (error) {
      throw Exception('Erro ao excluir morador ' + error);
    }
    return null;
  }
}
