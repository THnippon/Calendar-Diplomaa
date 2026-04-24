import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/repositories/users/models/user.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader ({
    super.key,
    required this.user
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24,),

      ],
    )
  }
}

class _UserIdBadge extends StatelessWidget{
  const _UserIdBadge({
    super.key,
    this.userId,
  });

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E4FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'ID $userId',
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6B4EFF),
        ),
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar ({
    super.key,
    required this.nickname,
  });

  final String nickname;

  String _getInitials() {
    final parts = nickname.trim().split(' ');
    if (parts.isEmpty) return '?';

    if (parts.length == 1)
    {
      return parts[0].substring(0, 1).toUpperCase();
    }

    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF5B3DF5),
            Color(0xFFA61EFF),
          ],
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            _getInitials(),
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5B3DF5),
            ),
          ),
        )
      ),
    );
  }
}