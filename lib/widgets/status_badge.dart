import 'package:flutter/material.dart';

/// Animated badge that shows the current Bluetooth detection status.
/// The colour and icon flip based on [detected].
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.detected,
  });

  final String label;
  final bool detected;

  @override
  Widget build(BuildContext context) {
    final color = detected
        ? const Color(0xFF34C759)   // iOS green
        : const Color(0xFF636366);  // iOS secondary grey

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.6), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Icon(
              detected ? Icons.bluetooth_connected : Icons.bluetooth_searching,
              key: ValueKey(detected),
              color: color,
              size: 22,
            ),
          ),
          // SizedBox respects text direction automatically.
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
