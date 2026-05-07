import 'package:flutter/material.dart';
import '../constants/assets_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage:
                  AppAssets.userAvatar.startsWith('assets/profile.jpg')
                  ? NetworkImage(AppAssets.userAvatar)
                  : AssetImage(AppAssets.userAvatar) as ImageProvider,
            ),
            const SizedBox(height: 16),
            const Text(
              'Moafaq Obaad',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Moafaqobaad@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            _buildProfileOption(
              context,
              Icons.shopping_bag_outlined,
              'My Orders',
            ),
            _buildProfileOption(
              context,
              Icons.location_on_outlined,
              'Shipping Address',
            ),
            _buildProfileOption(
              context,
              Icons.payment_outlined,
              'Payment Methods',
            ),
            _buildProfileOption(context, Icons.settings_outlined, 'Settings'),
            _buildProfileOption(
              context,
              Icons.help_outline_rounded,
              'Help Center',
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    IconData icon,
    String title,
  ) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: () {},
    );
  }
}
