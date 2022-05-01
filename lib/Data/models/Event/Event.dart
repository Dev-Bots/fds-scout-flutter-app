// ignore_for_file: file_names
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Event extends Equatable {
  const Event({
    required this.eventId,
    // this.profilePicture,
    required this.startingDate,
    required this.applicationDeadline,
    required this.description,
    required this.requiredPositions,
    required this.ageLimit,
    required this.educationLevel,
    required this.location,
    required this.gender,
    required this.sessionTimeForEach,
    this.club,
  });

  final int? eventId;

  final String? startingDate;
  final String? applicationDeadline;
  final String? description;
  final String? requiredPositions;
  final int? ageLimit;
  final String? educationLevel;
  final String? location;
  final String? gender;
  final int? sessionTimeForEach;
  final int? club;

  @override
  List<Object?> get props => [
        eventId,
        startingDate,
        applicationDeadline,
        description,
        requiredPositions,
        ageLimit,
        educationLevel,
        location,
        gender,
        sessionTimeForEach,
        club,
      ];

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventId: json['id'],
        startingDate: json['starting_date'],
        applicationDeadline: json['application_deadline'],
        description: json['description'],
        requiredPositions: json['required_positions'],
        ageLimit: json['age_limit'],
        educationLevel: json['education_level'],
        location: json['location'],
        gender: json['gender'],
        sessionTimeForEach: json['session_time_for_each'],
        // club: json['club'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = eventId;

    return data;
  }

  @override
  String toString() =>
      "TestAccount { eventId: $eventId, startingDate: $startingDate, applicationDeadline: $applicationDeadline, description: $description, requiredPositions: $requiredPositions, ageLimit: $ageLimit, educationLevel: $educationLevel, location: $location, }";
}
