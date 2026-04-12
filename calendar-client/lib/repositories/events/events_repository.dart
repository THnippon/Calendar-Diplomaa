import 'package:dio/dio.dart';
import 'package:flutter_application_1/repositories/events/events.dart';

class EventsRepository implements AbstractEventsRepository
{
  const EventsRepository({required Dio dio}) : _dio = dio;
  final Dio _dio;

  @override
  Future<List<Event>> getEvents() async {
    final response = await _dio.get('/events/All');

    final data = response.data as List<dynamic>;

    return data.map((item) => Event.fromJson(item as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<Event>> getEventsInRange(DateTime from, DateTime to) async {
    final response = await _dio.get('/events', queryParameters: {
      'from': from.toUtc().toIso8601String(),
      'to': to.toUtc().toIso8601String(),
    },
    );
    final data = response.data as List<dynamic>;
    return data.map((item) => Event.fromJson(item as Map<String, dynamic>)).toList();
  }
}