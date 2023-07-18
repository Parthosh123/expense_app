import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  TextEditingController controller;
  String? title;
  String? enterHint;
  final ValueChanged<String>? onChanged;
  bool? enabled;
  final inputType;
  final inputAction;

  TextFieldWidget({
    required this.controller,
    this.title,
    this.enterHint,
    this.onChanged,
    this.enabled,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.done,
  }) : super();

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: widget.inputAction,
      cursorColor: Colors.black,
      enabled: widget.enabled,
      controller: widget.controller,
      keyboardType: widget.inputType,
      onChanged: widget.onChanged,
      style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(color: Colors.deepPurple, width: 1),
        ),
        filled: true,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(color: Colors.deepPurple, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        fillColor: Colors.white,
        labelText: widget.enterHint,
        labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.7),
        ),
      ),
    );
  }
}
