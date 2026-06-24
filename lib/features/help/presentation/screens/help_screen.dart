import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.card,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Help & Support',
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
                  'Need Help?',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Support Center',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'We are here to help anytime',
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Quick Help',
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
                  Icons.support_agent,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Contact Support',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Talk with our support team',
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
                  Icons.payments,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Payment Issue',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Problem with card or wallet',
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
                  Icons.local_taxi,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Driver Complaint',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Report issue with a driver',
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
                  Icons.inventory_2,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Lost Item',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Recover something left in ride',
                style: TextStyle(color: Colors.black54),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Frequently Asked Questions',
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
              title: Text(
                'How can I cancel a ride?',
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(
                Icons.expand_more,
                color: Colors.black,
              ),
            ),
          ),
          Card(
            color: const Color(0xFFF2F2F2),
            child: const ListTile(
              title: Text(
                'How do I add a payment method?',
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(
                Icons.expand_more,
                color: Colors.black,
              ),
            ),
          ),
          Card(
            color: const Color(0xFFF2F2F2),
            child: const ListTile(
              title: Text(
                'How to contact the driver?',
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(
                Icons.expand_more,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
