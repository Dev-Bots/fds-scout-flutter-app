// ignore_for_file: file_names
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Team extends Equatable {
  const Team({
    required this.id,
    required this.formation,
    required this.eventId,
    required this.players,
  });

  final int? id;
  final int? eventId;
  final String? formation;
  final List? players;

  @override
  List<Object?> get props => [id, eventId, formation, players];

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json['id'],
        eventId: json['event'],
        formation: json['formation'],
        players: json['players'],
      );

  @override
  String toString() => "Team { eventId: $id, Team $formation";
}
