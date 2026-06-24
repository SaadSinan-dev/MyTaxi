import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'My Wallet',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Balance Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Balance',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '\$28.50',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          const Text(
            'Payment Methods',
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
                  Icons.credit_card,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Visa •••• 4242',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Default payment method',
                style: TextStyle(color: Colors.black54),
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
                'Cash',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),

          const SizedBox(height: 22),

          const Text(
            'Recent Transactions',
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
                  Icons.local_taxi,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Ride Payment',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Today • 5:40 PM',
                style: TextStyle(color: Colors.black54),
              ),
              trailing: Text(
                '- \$6.50',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Card(
            color: const Color(0xFFF2F2F2),
            child: const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Wallet Top Up',
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Yesterday',
                style: TextStyle(color: Colors.black54),
              ),
              trailing: Text(
                '+ \$20.00',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
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
                'Add Funds',
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
