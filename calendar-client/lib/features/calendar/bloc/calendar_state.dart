import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repositories/events/events.dart';

enum CalendarStatus {
  initial,
  loading,
  success,
  failure,
}

class CalendarState extends Equatable
{
  CalendarState ({
    this.status = CalendarStatus.initial,
    this.events = const [],
    this.errorMessage,
    DateTime? selectedDay
  }) : selectedDay = DateTime(
    (selectedDay ?? DateTime.now()).year,
    (selectedDay ?? DateTime.now()).month,
    (selectedDay ?? DateTime.now()).day,
  );



  final CalendarStatus status;
  final List<Event> events;
  final String? errorMessage;
  final DateTime selectedDay;

  @override
  List<Object?> get props => [
    status,
    events,
    errorMessage,
    selectedDay,
  ];

  CalendarState copyWith ({
    CalendarStatus? status,
    List<Event>? events,
    String? errorMessage,
    DateTime? selectedDay,
  }) {
    return CalendarState(
      status: status ?? this.status,
      events: events ?? this.events,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }
}