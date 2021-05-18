import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ListTileVeiculo extends StatelessWidget {
  final String texto;
  final Function onTap;

  ListTileVeiculo({this.texto, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: this.onTap,
        child: Column(
          children: [
            ListTile(
              title: Text(this.texto,
                  style: TextStyle(
                    fontSize: 18,
                  )),
              trailing: Icon(
                AntDesign.right,
                color: Colors.black,
              ),
            ),
            Divider(height: 8),
          ],
        ),
      ),
    );
  }
}
