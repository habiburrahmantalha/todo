import 'package:flutter/material.dart';
import 'package:todo/widgets/raw_button.dart';

class BottomSheetButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String label;
  final Color? color;
  const BottomSheetButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label, this.color
  });

  @override
  Widget build(BuildContext context) {
    return RawButton(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 12),
        color:color,
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).iconTheme.color),
            const SizedBox(width: 10,),
            Text(label, style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
        onTap: () => onTap()
    );
  }
}