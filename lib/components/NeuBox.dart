import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svrkxmdvm/themes/theme_provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    // is dark mode 
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          //darker shawdow on bottom right
          BoxShadow(
            color: isDarkMode?Colors.black: Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(3, 3)
          ),
          BoxShadow(
            color: isDarkMode? Colors.grey.shade800:  Colors.white,
            blurRadius: 15,
            offset: const Offset(-3, -3)
          ),
          //lighter shadow on top left
        ]
      ),
      padding: EdgeInsets.all(12),
      child: child,
    );
  }
}