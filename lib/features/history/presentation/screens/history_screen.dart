import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';

class SavedplacesScreen extends StatelessWidget {
  const SavedplacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Saved Places'),
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Access',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your Favorite Destinations',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Save places for faster booking',
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Saved Places',
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
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Mazzeh, Damascus',
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
            child: const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.work,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Work',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Business Center',
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
            child: const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.local_airport,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Airport',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Damascus International Airport',
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
            child: const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Favorite Cafe',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Abu Rummaneh',
                style: TextStyle(color: Colors.black54),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Add New Place',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
