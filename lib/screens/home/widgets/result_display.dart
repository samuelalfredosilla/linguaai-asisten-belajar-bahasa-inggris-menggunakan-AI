import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final String resultText;
  const ResultDisplay({ super.key, required this.resultText, });

  @override
  Widget build(BuildContext context) {
    if (resultText.isEmpty) { return const SizedBox.shrink(); }
    final bool isError = resultText.toLowerCase().startsWith('error:');
    final bool isInfo = resultText.toLowerCase().startsWith('info:');
    Color backgroundColor; Color borderColor; Color textColor; IconData? iconData;

    if (isError) { backgroundColor = Colors.red.shade50; borderColor = Colors.red.shade200; textColor = Colors.red.shade800; iconData = Icons.error_outline; }
    else if (isInfo) { backgroundColor = Colors.yellow.shade50; borderColor = Colors.yellow.shade300; textColor = Colors.yellow.shade800; iconData = Icons.info_outline;}
    else { backgroundColor = Colors.blue.shade50; borderColor = Colors.blue.shade200; textColor = Colors.black87; iconData = Icons.lightbulb_outline; }

    return Container(
      width: double.infinity, margin: const EdgeInsets.only(top: 15.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration( color: backgroundColor, border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(8.0), ),
      child: Row( crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (iconData != null) Padding( padding: const EdgeInsets.only(right: 8.0, top: 2.0), child: Icon(iconData, color: textColor, size: 18), ),
          Expanded( child: SelectableText( resultText, style: TextStyle(color: textColor, fontSize: 14), ), ),
        ],
      ),
    );
  }
}