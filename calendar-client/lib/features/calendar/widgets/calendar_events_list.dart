import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../repositories/events/events.dart';

class CalendarEventsList extends StatelessWidget {
  const CalendarEventsList ({
    super.key,
    required this.selectedDay,
    required this.events
  });

  final DateTime selectedDay;
  final List<Event> events;

  String _dayTitle(DateTime date)
  {
    if (isSameDay(date, DateTime.now())) return 'СЕГОДНЯ';
    final formatted = DateFormat('d MMMM', 'ru_RU').format(date);
    return formatted.toUpperCase();
  }

  String _eventsCount(int count)
  {
    if (count == 1) return '1 событие';
    if (count >=2 && count <= 4) return '$count события';
    return '$count событий';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(_dayTitle(selectedDay),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: Color(0xFF98A2B3),
            ),
            ),
            const Spacer(),
            Text(_eventsCount(events.length),
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF98A2B3),
            ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Expanded(
          child: events.isEmpty ? const _EmptyList()
           : ListView.separated(
            itemBuilder: (context, index) {
              final event = events[index];

            }, 
            separatorBuilder: (_, __) => const SizedBox(height: 12), 
            itemCount: events.length))
      ],
    );
  }
}

class _EmptyList extends StatelessWidget
{
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFFF2F4F7),
            child: Icon(Icons.calendar_today_outlined,
              color: Color(0xFF98A2B3),
              ),
          ),
          SizedBox(height: 16),
          Text('На этот день собтий нет',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF98A2B3),
            fontWeight: FontWeight.w500,
          ),
          ),
        ],
      ),
    );
  }
}

class _DayEvents extends StatelessWidget
{
  const _DayEvents({
    required this.event,
    this.onEventSelected
  });

  final Event event;
  ValueChanged<Event>? onEventSelected;


}