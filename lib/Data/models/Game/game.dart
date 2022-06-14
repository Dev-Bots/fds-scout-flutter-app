// ignore_for_file: file_names
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Game extends Equatable {
  Game({
    required this.gameId,
    required this.eventId,
    required this.team1,
    required this.team2,
    this.time,
  });

  final int? gameId;
  final int? eventId;
  final int? team1;
  final int? team2;
  var time;

  @override
  List<Object?> get props => [gameId, eventId, team1, team2];

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        gameId: json['id'],
        eventId: json['event'],
        team1: json['team1'],
        team2: json['team2'],
        time: json['time'],

        // club: json['club'],
      );

  @override
  String toString() =>
      "TestMatches { eventId: $eventId, Team $team1 vs Team $team2}";
}
