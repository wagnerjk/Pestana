import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputCustomizado extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final bool enabled;
  final bool autofocus;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final Function(String) validator;
  final Function onTap;
  final Function(String) onFieldSubmitted;
  final Function(String) onSaved;
  final Function(String) onChanged;
  final TextCapitalization textCapitalization;
  final Widget sufixIcon;

  InputCustomizado(
      {this.controller,
        this.label,
        this.autofocus = false,
        this.focusNode,
        this.keyboardType,
        this.inputFormatters,
        this.validator,
        this.onSaved,
        this.onChanged,
        this.textCapitalization = TextCapitalization.none,
        this.textInputAction,
        this.onFieldSubmitted,
        this.sufixIcon,
        this.enabled,
        this.onTap,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      enabled: this.enabled,
      autofocus: this.autofocus,
      focusNode: this.focusNode,
      keyboardType: this.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: this.textInputAction,
      inputFormatters: this.inputFormatters,
      validator: this.validator,
      onTap: this.onTap,
      onSaved: this.onSaved,
      onChanged: this.onChanged,
      onFieldSubmitted: this.onFieldSubmitted,
      textCapitalization: this.textCapitalization,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          labelText: this.label,
          labelStyle: TextStyle(fontSize: 16),
          suffixIcon: this.sufixIcon,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6)
          )
      ),
    );
  }
}
