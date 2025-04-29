import 'package:flutter/material.dart';
import 'result_display.dart';

class FeatureCard extends StatelessWidget {
  final String title; final TextEditingController inputController; final String inputHint;
  final String buttonText; final VoidCallback onPressed; final bool isLoading;
  final String result; final bool isMultiLineInput;

  const FeatureCard({ super.key, required this.title, required this.inputController, required this.inputHint, required this.buttonText, required this.onPressed, required this.isLoading, required this.result, this.isMultiLineInput = false, });

  @override
  Widget build(BuildContext context) {
    return Card( elevation: 1, margin: const EdgeInsets.only(bottom: 16.0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)), clipBehavior: Clip.antiAlias,
      child: Padding( padding: const EdgeInsets.all(16.0),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( title, style: Theme.of(context).textTheme.titleLarge?.copyWith( fontWeight: FontWeight.w500,),),
            const SizedBox(height: 15),
            TextField( controller: inputController, decoration: InputDecoration( hintText: inputHint, border: const OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide.none ), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14), isDense: true, filled: true, fillColor: Colors.grey.shade100 ), keyboardType: isMultiLineInput ? TextInputType.multiline : TextInputType.text, maxLines: isMultiLineInput ? 3 : 1, minLines: isMultiLineInput ? 2 : 1, textInputAction: isMultiLineInput ? TextInputAction.newline : TextInputAction.done, ),
            const SizedBox(height: 12),
            Align( alignment: Alignment.centerRight,
              child: ElevatedButton.icon( onPressed: isLoading ? null : onPressed,
                icon: isLoading ? Container( width: 18, height: 18, padding: const EdgeInsets.all(2.0), child: const CircularProgressIndicator( color: Colors.white, strokeWidth: 2, ), ) : const Icon(Icons.send, size: 18),
                label: Text(isLoading ? 'Memproses...' : buttonText),
                style: ElevatedButton.styleFrom( padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), ),
              ),
            ),
            ResultDisplay(resultText: result),
          ],
        ),
      ),
    );
  }
}