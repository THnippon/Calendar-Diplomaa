import 'package:equatable/equatable.dart';

class Event extends Equatable
{
  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startAt,
    required this.endAt,
    required this.address,
    required this.createdBy,
    required this.scopeCode,
    required this.groupId,
  });

  final int id;
  final String? title;
  final String? description;
  final DateTime startAt;
  final DateTime endAt;
  final String? address;
  final int createdBy;
  final String scopeCode;
  final int? groupId;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    startAt,
    endAt,
    address,
    createdBy,
    scopeCode,
    groupId,
  ];

  factory Event.fromJson (Map<String, dynamic> json)
  {
    return Event(
      id: json['id'] as int,
      title: json['title'] as String?,
      description: json['description'] as String?,
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      address: json['address'] as String?,
      createdBy: json['createdBy'] as int,
      scopeCode: json['scopeCode'] as String,
      groupId: json['groupId'] as int?,
    );
  }
}