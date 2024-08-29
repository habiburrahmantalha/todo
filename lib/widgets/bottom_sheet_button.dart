import 'package:flutter/material.dart';
import 'package:todo/widgets/raw_button.dart';

class BottomSheetButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String label;

  const BottomSheetButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return RawButton(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 12),
        color: label == "Delete" ? Theme.of(context).colorScheme.onError : null,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10,),
            Text(label)
          ],
        ),
        onTap: () => onTap()
    );
  }
}