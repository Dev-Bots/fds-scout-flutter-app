import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Parameter extends Equatable {
  const Parameter({
    required this.event_id,
    required this.skills,
  });

  final int? event_id;
  final List<Skill>? skills;

  @override
  List<Object?> get props => [event_id, skills];

  factory Parameter.fromJson(Map<String, dynamic> json) => Parameter(
      event_id: json['event']['id'],
      skills: json['skills'].map((skill) => Skill.fromJson(skill)).toList());
}

class Skill {
  const Skill(
      {required this.skillId,
      required this.name,
      required this.description,
      required this.weight_for_GK,
      required this.weight_for_DEF,
      required this.weight_for_MID,
      required this.weight_for_STR,
      this.is_default,
      this.club});

  final int? skillId;
  final int? name;
  final String? description;
  final int? weight_for_GK;
  final int? weight_for_DEF;
  final int? weight_for_MID;
  final int? weight_for_STR;
  final int? is_default;
  final int? club;

  @override
  List<Object?> get props => [
        skillId,
        name,
        description,
        weight_for_DEF,
        weight_for_GK,
        weight_for_MID,
        weight_for_STR,
        club
      ];

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        skillId: json['id'],
        name: json['name'],
        description: json['description'],
        weight_for_GK: json['weight_for_GK'],
        weight_for_DEF: json['weight_for_DEF'],
        weight_for_MID: json['weight_for_MID'],
        weight_for_STR: json['weight_for_STR'],
        is_default: json['is_default'],
        club: json['club'],
      );

  @override
  String toString() => "Skill { eventId: $skillId, Team $name}";
}
