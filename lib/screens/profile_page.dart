import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                child: const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xFFE94560),
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                child: const Text(
                  'Moafaq User',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: const Text(
                  'moafaq@example.com',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 40),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: _buildProfileOption(Icons.history, 'My Orders'),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: _buildProfileOption(Icons.payment, 'Payment Methods'),
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: _buildProfileOption(Icons.settings, 'Settings'),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Logout', style: TextStyle(color: Colors.red, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFE94560)),
          const SizedBox(width: 20),
          Text(title, style: const TextStyle(fontSize: 18)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
