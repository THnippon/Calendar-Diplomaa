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

class _UserAvatar