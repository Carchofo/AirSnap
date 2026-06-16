import 'package:flutter/material.dart';

/// Full-width primary action button used on the Home screen.
class CalibrateButton extends StatelessWidget {
  const CalibrateButton({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: FilledButton.icon(
        onPressed: () {
          // TODO(dev): wire calibration logic here.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(label), duration: const Duration(seconds: 1)),
          );
        },
        icon: const Icon(Icons.tune_rounded),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
