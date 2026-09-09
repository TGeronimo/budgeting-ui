import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              body: SafeArea(
                child: LayoutBuilder(
                  builder: (context, viewportConstraints) {
                    return SingleChildScrollView(
                            child: AnimatedContainer(
                              color: const Color.fromARGB(255, 161, 195, 246).withValues(alpha: 0.8),
                              duration: const Duration(milliseconds: 200),
                              constraints: BoxConstraints(
                                minHeight: viewportConstraints.maxHeight,
                                ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 360),
                                    child: child,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
  }
}