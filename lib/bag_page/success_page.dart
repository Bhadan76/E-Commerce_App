import 'package:flutter/material.dart';
import '../app_routes.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Illustration (Shopping Bags & Confetti)
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Confetti effect (using simple containers for now)
                    ...List.generate(12, (index) {
                      final angle = (index * 30) * (3.14159 / 180);
                      return Transform.translate(
                        offset: Offset(
                          80 * (index % 2 == 0 ? 1 : 1.2) * (index > 6 ? 1.2 : 1) * (index % 3 == 0 ? 0.8 : 1) * (index % 4 == 0 ? 0.5 : 1) * (index % 5 == 0 ? 1.5 : 1) * (index % 6 == 0 ? 0.2 : 1),
                          80 * (index % 2 == 0 ? 1 : 1.2) * (index > 6 ? 1.2 : 1) * (index % 3 == 0 ? 0.8 : 1) * (index % 4 == 0 ? 0.5 : 1) * (index % 5 == 0 ? 1.5 : 1) * (index % 6 == 0 ? 0.2 : 1),
                        ), // Just a dummy placeholder for confetti
                        child: Container(),
                      );
                    }),
                    // Better to use an image if possible, but I'll create a simple vector-like UI
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/3502/3502601.png', // Shopping bags icon
                      height: 200,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.shopping_bag_outlined,
                        size: 150,
                        color: Color(0xFFDB3022),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              const Text(
                'Success!',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your order will be delivered soon.\nThank you for choosing our app!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to home or catalog
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.main,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDB3022),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFFDB3022).withOpacity(0.5),
                  ),
                  child: const Text(
                    'CONTINUE SHOPPING',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
