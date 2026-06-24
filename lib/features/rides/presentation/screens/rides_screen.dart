import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';

class RidesScreen extends StatelessWidget {
  const RidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.textWhite,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Rides',
          style: TextStyle(color: Colors.white),
        ),
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
                  'Current Ride',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Driver arriving in 4 min',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Toyota Prius • 214578',
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Ride History',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Card(
            color: const Color(0xFFF2F2F2),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.local_taxi,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                'Damascus Mall → Mazzeh',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: const Text(
                'Today • 5:40 PM',
                style: TextStyle(color: Colors.black54),
              ),
              trailing: const Text(
                '\$6.50',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Card(
            color: const Color(0xFFF2F2F2),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.local_taxi,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                'Airport → Abu Rummaneh',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: const Text(
                'Yesterday • 1:15 PM',
                style: TextStyle(color: Colors.black54),
              ),
              trailing: const Text(
                '\$14.00',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Card(
            color: const Color(0xFFF2F2F2),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.local_taxi,
                  color: Colors.black,
                ),
              ),
              title: const Text(
                'Kafarsouseh → Shaalan',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: const Text(
                'Apr 18 • 9:10 PM',
                style: TextStyle(color: Colors.black54),
              ),
              trailing: const Text(
                '\$4.75',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
