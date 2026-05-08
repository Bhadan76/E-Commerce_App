import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(svgPath: 'asset/google.svg', size: 22),
        const SizedBox(width: 14),
        _SocialIcon(imagePath: 'asset/facebook.png', size: 22),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final String? svgPath;
  final String? imagePath;
  final double size;

  const _SocialIcon({this.svgPath, this.imagePath, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: _buildIcon(),
    );
  }

  Widget _buildIcon() {
    if (svgPath != null) {
      return SvgPicture.asset(svgPath!, width: size, height: size);
    }
    if (imagePath != null) {
      return Image.asset(imagePath!, width: size, height: size);
    }
    return const SizedBox.shrink();
  }
}
