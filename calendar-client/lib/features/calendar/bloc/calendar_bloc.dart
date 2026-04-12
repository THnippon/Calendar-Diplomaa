import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';
import 'package:flutter_application_1/repositories/events/events.dart';


class CalendarBloc extends Bloc<CalendarEvent, CalendarState>
{
  CalendarBloc ({
    required AbstractEventsRepository eventRepository,
  }) : _eventRepository = eventRepository,
      super(CalendarState())
      {
        on<CalendarStarted>(_onCalendarStarted);
        on<CalendarMonthChanged>(_onCalendarMonthChanged);
        on<CalendarDaySelected>(_onCalendarDaySelected);
      }

  final AbstractEventsRepository _eventRepository;

  DateTime _dateOnly (DateTime date)
  {
    return DateTime(date.year, date.month, date.day);
  }
  Future<void> _loadMonth(
    DateTime focusedDay,
    Emitter<CalendarState> emit
  )
  async
  {
    emit(
      state.copyWith(
        status: CalendarStatus.loading,
        errorMessage: null,
      ),
    );
  
    try
    {
      final monthStart = DateTime(focusedDay.year, focusedDay.month, 1);
      final monthEnd = DateTime(focusedDay.year, focusedDay.month+1, 1);
      final events = await _eventRepository.getEventsInRange(monthStart, monthEnd);

      emit(
        state.copyWith(
          status: CalendarStatus.success,
          events: events,
          errorMessage: null,
        ),
      );
    } catch (error)
    {
      emit(
        state.copyWith(
          status: CalendarStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onCalendarStarted(
    CalendarStarted e,
    Emitter<CalendarState> emit
  )
  async
  {
    await _loadMonth(e.focusedDay, emit);
  }

  Future<void> _onCalendarMonthChanged(
    CalendarMonthChanged e,
    Emitter<CalendarState> emit
  )
  async
  {
    await _loadMonth(e.focusedDay, emit);
  }

  void _onCalendarDaySelected(
    CalendarDaySelected e,
    Emitter<CalendarState> emit
  )
  {
    emit(state.copyWith(selectedDay: _dateOnly(e.selectedDay)));
  }
}
