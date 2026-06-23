import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saad Sinan',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '+963 9XX XXX XXX',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.edit,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Preferences',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 14),
          Card(
            color: const Color(0xFFF2F2F2),
            child: const ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.black,
              ),
              title: Text(
                'Language',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'English',
                style: TextStyle(color: Colors.black54),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
            ),
          ),
          Card(
            color: const Color(0xFFF2F2F2),
            child: SwitchListTile(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primary,
              title: const Text(
                'Notifications',
                style: TextStyle(color: Colors.black),
              ),
              secondary: const Icon(
                Icons.notifications,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 14),
          Card(
            color: const Color(0xFFF2F2F2),
            child: const ListTile(
              leading: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              title: Text(
                'Privacy & Security',
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
            ),
          ),
          Card(
            color: const Color(0xFFF2F2F2),
            child: const ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Colors.black,
              ),
              title: Text(
                'About App',
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
            ),
          ),
          Card(
            color: const Color(0xFFF2F2F2),
            child: ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
