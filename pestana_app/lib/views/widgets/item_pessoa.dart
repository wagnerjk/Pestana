import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:pestana_app/data/model/pessoa_model.dart';

class ItemPessoa extends StatelessWidget {
  final Pessoa pessoa;
  final VoidCallback onTapItem;

  ItemPessoa({@required this.pessoa, this.onTapItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: this.onTapItem,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pessoa.nome,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Apartamento: ${pessoa.apartamento}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Telefone: ' + UtilBrasilFields.obterTelefone(pessoa.telefone).toString(),
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
