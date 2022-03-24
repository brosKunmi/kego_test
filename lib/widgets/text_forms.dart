import 'package:flutter/material.dart';

class TextForms extends StatelessWidget {
  const TextForms({
    Key? key,
    this.maxLines,
    required this.onSubmitted,
    required this.hint,
    this.initial,
  }) : super(key: key);

  final int? maxLines;
  final String? initial;
  final Function(String?) onSubmitted;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(8),
        boxShadow: kElevationToShadow[6],
      ),
      child: TextFormField(
          keyboardType: TextInputType.text,
          initialValue: initial ?? '',
          textCapitalization: TextCapitalization.sentences,
          onSaved: onSubmitted,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusColor: Colors.grey,
            labelText: hint,
            hintStyle: const TextStyle(
              fontSize: 16,
            ),
          )),
    );
  }
}
