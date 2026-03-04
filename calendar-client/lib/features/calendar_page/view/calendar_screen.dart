import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/calendar_page/widgets/calendar.dart';

class CalendarScreen extends StatelessWidget
{
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Календарь"),
        actions: [
          IconButton(
            onPressed: () {}, icon: const Icon(Icons.search),
            ),
        ]
      ),
      body: Padding(padding: const EdgeInsets.all(16),
      child: CalendarCard(),
      ),
    );
  }
}