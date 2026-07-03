import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app theme/bloc/theme_bloc.dart';


class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.isDark;

        return GestureDetector(
          onTap: () => context.read<ThemeBloc>().add(ToggleThemeEvent()),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1E1E2E)
                  : const Color(0xFFE8F4FD),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.08),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _AnimatedTrack(isDark: isDark),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        isDark ? 'Dark mode' : 'Light mode',
                        key: ValueKey(isDark),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Text(
                      'Tap to switch',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedTrack extends StatelessWidget {
  final bool isDark;
  const _AnimatedTrack({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      width: 56,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: isDark ? const Color(0xFF1A1A2E) : const Color(0xFFBBDEFB),
      ),
      child: Stack(
        children: [
          // Stars (visible in dark mode)
          if (isDark) ...[
            _star(top: 6, left: 8),
            _star(top: 14, left: 14, size: 2),
            _star(top: 8, left: 22, size: 2),
          ],
          // Thumb
          AnimatedAlign(
            duration: const Duration(milliseconds: 350),
            curve: Curves.elasticOut,
            alignment:
                isDark ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? const Color(0xFF2D2B55)
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      isDark ? '🌙' : '☀️',
                      key: ValueKey(isDark),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _star({required double top, required double left, double size = 3}) {
    return Positioned(
      top: top,
      left: left,
      child: AnimatedOpacity(
        opacity: isDark ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}