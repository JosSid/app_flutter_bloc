import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final IconData? icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isTextArea;
  final bool error;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.isTextArea = false,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        maxLines: isTextArea ? 6 : null,
        style: const TextStyle(color: Colors.white54),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: error ? Theme.of(context).primaryColor : Colors.white54),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: error ? Theme.of(context).primaryColor : Colors.white),
          ),
          labelStyle: TextStyle(
              color: error ? Theme.of(context).primaryColor : Colors.white),
          label: Text(label),
          suffixIcon: icon != null
              ? Icon(
                  icon,
                  color: error ? Theme.of(context).primaryColor : Colors.grey,
                )
              : null,
        ),
      ),
    );
  }
}
