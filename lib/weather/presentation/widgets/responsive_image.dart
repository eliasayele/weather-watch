import 'package:flutter/material.dart';

class ResponsiveImage extends StatelessWidget {
  const ResponsiveImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the aspect ratio based on the width of the screen
        double aspectRatio = constraints.maxWidth < 300 ? 4 / 3 : 16 / 9;
        return AspectRatio(
          aspectRatio: aspectRatio,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset('assets/images/sunshine.png'),
          ),
        );
      },
    );
  }
}
