import 'package:flutter_application_1/repositories/events/models/models.dart';

abstract interface class AbstractEventsRepository {
  Future<List<Event>> getEvents();
  Future<List<Event>> getEventsInRange(DateTime from, DateTime to);
}