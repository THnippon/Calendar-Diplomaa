import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/calendar_page/widgets/calendar_header.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCard extends StatefulWidget
{
  const CalendarCard ({
    super.key,
    this.firstDay,
    this.lastDay,
    this.onDaySelected,
  });

  final DateTime? firstDay;
  final DateTime? lastDay;

  final void Function(DateTime selectedDay, DateTime focusedDay)? onDaySelected;


  @override
  State<CalendarCard> createState() => _CalendarCardState();
}
  class _CalendarCardState extends State<CalendarCard>
  {
    late DateTime _selectedDay;
    late DateTime _focusedDay;
    PageController? _pageController;

  @override
  void initState()
  {
    super.initState();
    _selectedDay = DateUtils.dateOnly(DateTime.now());
    _focusedDay = _selectedDay;
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
              },
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = DateUtils.dateOnly(selectedDay);
                  _focusedDay = focusedDay;
                });
                widget.onDaySelected?.call(_selectedDay, _focusedDay);
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(_dateTitle(_selectedDay)),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}