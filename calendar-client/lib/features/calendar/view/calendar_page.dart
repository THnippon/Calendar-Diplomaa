import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/calendar/bloc/calendar_bloc.dart';
import 'package:flutter_application_1/features/calendar/bloc/calendar_event.dart';
import 'package:flutter_application_1/features/calendar/view/calendar_screen.dart';
import 'package:flutter_application_1/repositories/events/events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/di/di.dart';


class CalendarPage extends StatelessWidget
{
  const CalendarPage({super.key});

  @override
  Widget build( BuildContext context)
  {
    return BlocProvider(
      create: (_) => CalendarBloc(eventRepository: sl<AbstractEventsRepository>())..add(CalendarStarted(focusedDay: DateTime.now())),
      child: CalendarScreen(),
    );
  }
}