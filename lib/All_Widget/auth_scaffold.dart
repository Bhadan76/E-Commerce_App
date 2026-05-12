import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  final bool showBack;
  final String title;
  final Widget child;

  const AuthScaffold({
    super.key,
    required this.showBack,
    required this.title,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = width * 0.064;
    final titleSize = (width * 0.094).clamp(30.0, 36.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(

        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBackButton(showBack: showBack),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 24),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class AuthField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const AuthField({
    super.key,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.black45),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFDCDCDC)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFDB3022), width: 1.2),
        ),
      ),
    );
  }
}

class PrimaryAuthButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const PrimaryAuthButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDB3022),
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 2,
          shadowColor: const Color(0x40DB3022),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
    );
  }
}

class _TopBackButton extends StatelessWidget {
  final bool showBack;

  const _TopBackButton({required this.showBack});

  @override
  Widget build(BuildContext context) {
    if (!showBack) {
      return const SizedBox(height: 32);
    }

    return InkWell(
      onTap: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(20),
      child: const Padding(
        padding: EdgeInsets.all(4),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: Colors.black87,
        ),
      ),
    );
  }
}
