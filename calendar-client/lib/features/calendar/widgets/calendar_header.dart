import 'package:flutter/material.dart';


class CalendarHeader extends StatelessWidget
{
  final String title;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const CalendarHeader({
    super.key, required this.title, required this.onPrevious, required this.onNext
  });

  @override
  Widget build(BuildContext context)
  {
    return Row(
                children: [
                  IconButton(onPressed: onPrevious, icon: const Icon(Icons.chevron_left)),
                  Expanded(child: Center(child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),),),
                  IconButton(onPressed: onNext, icon: const Icon(Icons.chevron_right)),
                ],
              );
  }
}