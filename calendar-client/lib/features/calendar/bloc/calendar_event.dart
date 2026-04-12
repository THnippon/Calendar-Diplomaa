import 'package:equatable/equatable.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object?> get props => [];
}

class CalendarStarted extends CalendarEvent
{
  const CalendarStarted({required this.focusedDay});

  final DateTime focusedDay;
  
  @override
  List<Object?> get props => [focusedDay];
}

class CalendarMonthChanged extends CalendarEvent
{
   const CalendarMonthChanged({required this.focusedDay});

  final DateTime focusedDay;
  
  @override
  List<Object?> get props => [focusedDay];
}

class CalendarDaySelected extends CalendarEvent
{
  const CalendarDaySelected({required this.selectedDay});

  final DateTime selectedDay;

  @override
  List<Object?> get props => [selectedDay];
}