import 'package:flutter/material.dart';

class LanguageField extends StatelessWidget {
  const LanguageField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.sizeOf(context).width - 60) * 0.45,
      child: Text(
        "Language",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
