import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/calendar/widgets/calendar_card.dart';
import 'package:flutter_application_1/features/calendar/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Календарь'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          final selectedDayEvents = state.events.where((event)
          {
            final eventDay = DateUtils.dateOnly(event.startAt.toLocal());
            return isSameDay(eventDay, state.selectedDay);
          }).toList(); 
          if (state.status == CalendarStatus.failure) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Ошибка загрузки календаря событий',
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CalendarCard(
                  events: state.events,
                  selectedDay: state.selectedDay,
                  onMonthChanged: (focusedDay) {
                    context.read<CalendarBloc>().add(
                          CalendarMonthChanged(focusedDay: focusedDay),
                        );
                  },
                  onDaySelected: (selectedDay) {
                    context.read<CalendarBloc>().add(
                          CalendarDaySelected(selectedDay: selectedDay),
                        );
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    // Перенести в папку widgets!
                    itemCount: selectedDayEvents.length,
                    itemBuilder: (context, index) {
                      final event = selectedDayEvents[index];

                      return ListTile(
                        title: Text(event.title ?? 'Без названия'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}