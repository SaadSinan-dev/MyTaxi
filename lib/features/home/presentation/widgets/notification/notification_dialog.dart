import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_taxi/core/colors/app_colors.dart';

// ─── Notification Model ───────────────────────────────────────────────────────
class NotificationItem {
  final String title;
  final String subtitle;
  final String time;
  final NotificationType type;
  final bool isRead;

  const NotificationItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

enum NotificationType { ride, promo, system, payment }

// ─── Mock Data ────────────────────────────────────────────────────────────────
const _mockNotifications = [
  NotificationItem(
    title: 'Ride Confirmed!',
    subtitle: 'Your driver Ahmed is 3 min away · Toyota Camry',
    time: '2m ago',
    type: NotificationType.ride,
    isRead: false,
  ),
  NotificationItem(
    title: 'Payment Successful',
    subtitle: '\$12.50 charged to Visa ending in 4242',
    time: '1h ago',
    type: NotificationType.payment,
    isRead: false,
  ),
  NotificationItem(
    title: '20% Off Your Next Ride 🎉',
    subtitle: 'Use code SAVE20 before midnight tonight',
    time: '3h ago',
    type: NotificationType.promo,
    isRead: true,
  ),
  NotificationItem(
    title: 'Ride Completed',
    subtitle: 'You traveled 5.2 km · Rate your experience',
    time: 'Yesterday',
    type: NotificationType.ride,
    isRead: true,
  ),
  NotificationItem(
    title: 'App Update Available',
    subtitle: 'New features and performance improvements',
    time: '2d ago',
    type: NotificationType.system,
    isRead: true,
  ),
];

// ─── Dialog ──────────────────────────────────────────────────────────────────
class NotificationDialog extends StatelessWidget {
  const NotificationDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Notifications',
      barrierColor: Colors.black.withOpacity(0.4),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const NotificationDialog();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.05),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final unreadCount = _mockNotifications.where((n) => !n.isRead).length;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              width: size.width * 0.88,
              constraints: BoxConstraints(maxHeight: size.height * 0.65),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.97),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 40,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Header ──
                  _Header(unreadCount: unreadCount),

                  // ── Divider ──
                  Divider(height: 1, color: Colors.grey.shade100),

                  // ── List ──
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: _mockNotifications.length,
                      itemBuilder: (context, index) {
                        return _NotificationTile(
                          item: _mockNotifications[index],
                        );
                      },
                    ),
                  ),

                  // ── Footer ──
                  _Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Header ──────────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final int unreadCount;
  const _Header({required this.unreadCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 16),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.notifications_rounded,
              color: AppColors.primary,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          // Title + Count
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                if (unreadCount > 0)
                  Text(
                    '$unreadCount unread',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),

          // Mark all read
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
            ),
            child: Text(
              'Mark all read',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.primary,
              ),
            ),
          ),

          // Close
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close_rounded,
                  size: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Notification Tile ────────────────────────────────────────────────────────
class _NotificationTile extends StatelessWidget {
  final NotificationItem item;
  const _NotificationTile({required this.item});

  IconData get _icon {
    switch (item.type) {
      case NotificationType.ride:
        return Icons.local_taxi_rounded;
      case NotificationType.payment:
        return Icons.receipt_long_rounded;
      case NotificationType.promo:
        return Icons.local_offer_rounded;
      case NotificationType.system:
        return Icons.info_rounded;
    }
  }

  Color get _iconColor {
    switch (item.type) {
      case NotificationType.ride:
        return AppColors.primary;
      case NotificationType.payment:
        return Colors.green;
      case NotificationType.promo:
        return Colors.orange;
      case NotificationType.system:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: item.isRead
          ? Colors.transparent
          : AppColors.primary.withOpacity(0.03),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon ──
            Stack(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(_icon, color: _iconColor, size: 20),
                ),
                if (!item.isRead)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontWeight:
                          item.isRead ? FontWeight.w500 : FontWeight.w700,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ── Time ──
            Text(
              item.time,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Footer ──────────────────────────────────────────────────────────────────
class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1, color: Colors.grey.shade100),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey.shade600,
            ),
            child: const Text(
              'See all notifications',
              style: TextStyle(fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
