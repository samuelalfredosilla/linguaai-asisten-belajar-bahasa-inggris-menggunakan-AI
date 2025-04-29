import 'package:flutter/material.dart';
import 'result_display.dart';

class PracticeCard extends StatelessWidget {
  final String title; final VoidCallback onPressed;
  final bool isLoading; final String result;

  const PracticeCard({ super.key, required this.title, required this.onPressed, required this.isLoading, required this.result, });

  @override
  Widget build(BuildContext context) {
    return Card( elevation: 1, margin: const EdgeInsets.only(bottom: 16.0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)), clipBehavior: Clip.antiAlias,
      child: Padding( padding: const EdgeInsets.all(16.0),
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( title, style: Theme.of(context).textTheme.titleLarge?.copyWith( fontWeight: FontWeight.w500,),),
            const SizedBox(height: 15),
            Align( alignment: Alignment.centerRight,
              child: ElevatedButton.icon( onPressed: isLoading ? null : onPressed,
                icon: isLoading ? Container( width: 18, height: 18, padding: const EdgeInsets.all(2.0), child: const CircularProgressIndicator( color: Colors.white, strokeWidth: 2, ), ) : const Icon(Icons.refresh, size: 18),
                label: Text(isLoading ? 'Memuat...' : "Minta Latihan Baru"),
                style: ElevatedButton.styleFrom( padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8)), ),
              ),
            ),
            ResultDisplay(resultText: result),
          ],
        ),
      ),
    );
  }
}