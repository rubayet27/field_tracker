import 'package:flutter/material.dart';
import '../../../core/extensions/responsive_extensions.dart';
import '../../../utils/app_colors.dart';

class EditMapWidget extends StatelessWidget {
  const EditMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      height: 200.00.setHeight(),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.componentDark : AppColors.componentLight,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Map grid lines helper
          CustomPaint(
            size: const Size(double.infinity, 200),
            painter: GridPainter(isDarkMode: isDarkMode),
          ),
          // Geofence Circle representation
          Container(
            width: 120.00.setWidth(),
            height: 120.00.setHeight(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(0.08),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.4),
                width: 1.5,
              ),
            ),
          ),
          // Location Pin in Center
          const Icon(Icons.location_on, color: AppColors.primary, size: 38),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final bool isDarkMode;
  GridPainter({required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!
      ..strokeWidth = 1.0;

    // Draw horizontal grid lines
    for (double y = 40; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw vertical grid lines
    for (double x = 40; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
