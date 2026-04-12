

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/calendar/widgets/calendar_header.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_application_1/repositories/events/events.dart';

class CalendarCard extends StatefulWidget
{
  const CalendarCard ({
    super.key,
    this.firstDay,
    this.lastDay,
    required this.events,
    required this.selectedDay,
    this.onDaySelected,
    this.onMonthChanged
  });

  final DateTime? firstDay;
  final DateTime? lastDay;
  final List<Event> events;
  final DateTime selectedDay;

  final ValueChanged<DateTime>? onMonthChanged;
  final ValueChanged<DateTime>? onDaySelected;


  @override
  State<CalendarCard> createState() => _CalendarCardState();
}
  class _CalendarCardState extends State<CalendarCard>
  {
    late DateTime _focusedDay;
    PageController? _pageController;

  @override
  void initState()
  {
    super.initState();
    _focusedDay = DateUtils.dateOnly(widget.selectedDay);
  }

  @override
  void didUpdateWidget(covariant oldWidget)
  {
    super.didUpdateWidget(oldWidget);

    if (!isSameDay(oldWidget.selectedDay, widget.selectedDay)) {
      _focusedDay = DateUtils.dateOnly(widget.selectedDay);
    }
  }
  

  String _monthTitle (DateTime day)
  {
    final month = DateFormat.MMMM('ru_RU').format(day);
    final monthCap = month[0].toUpperCase() + month.substring(1);
    return '$monthCap ${day.year}';
  }

  String _dateTitle (DateTime day)
  {
    if (isSameDay(day, DateTime.now()))
    {
      return 'СЕГОДНЯ';
    }
    final d = DateFormat('d MMMM', 'ru_RU').format(day);
    return d.toUpperCase();
  }

  void _goToPreviousMonth()
  {
    _pageController?.previousPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  void _goToNextMonth()
  {
    _pageController?.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  List<Event> _eventsForDay(DateTime day)
  {
    final targetDay = DateUtils.dateOnly(day);

    return widget.events.where((event) {
      final eventDay = DateUtils.dateOnly(event.startAt.toLocal());
      return eventDay == targetDay;
    }).toList();
  }
   @override
  Widget build(BuildContext context) {
    final first = widget.firstDay ?? DateTime.utc(2000, 1, 1);
    final last = widget.lastDay ?? DateTime.utc(2100, 12, 31);

    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(32),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CalendarHeader(
              title: _monthTitle(_focusedDay),
              onPrevious: _goToPreviousMonth,
              onNext: _goToNextMonth,
            ),
            TableCalendar(
              locale: 'ru_RU',
              headerVisible: false,
              availableCalendarFormats: const {CalendarFormat.month: 'Месяц'},
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                todayDecoration: BoxDecoration(

                  color: Colors.deepPurple.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: const TextStyle(color: Colors.white),
              ),
              focusedDay: _focusedDay,
              firstDay: first,
              lastDay: last,
              calendarFormat: CalendarFormat.month,
              onCalendarCreated: (pageController) {
                _pageController = pageController;
              },
              onPageChanged: (focusedDay) {
                setState(() => _focusedDay = focusedDay);
                widget.onMonthChanged?.call(focusedDay);
              },
              selectedDayPredicate: (day) => isSameDay(DateUtils.dateOnly(widget.selectedDay), day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = DateUtils.dateOnly(focusedDay);
                });
                widget.onDaySelected?.call(DateUtils.dateOnly(selectedDay));
              },
              eventLoader: _eventsForDay,
              calendarBuilders: CalendarBuilders(
                markerBuilder:(context, day, events) {
                  if (events.isEmpty) return null;
                  final visibleMarkersCount = events.length > 3 ? 3 : events.length;
                  const markerColor = Color(0xFFFF9800);
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(visibleMarkersCount, (index)
                      {
                        return Container(
                          width: 5,
                      height: 5,
                      margin: const EdgeInsets.symmetric(horizontal: 1.5),
                      decoration: const BoxDecoration(
                        color: markerColor,
                        shape: BoxShape.circle
                        ),
                        );
                      }),
                      ),
                    );
                },
                  ),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(_dateTitle(DateUtils.dateOnly(widget.selectedDay))),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}