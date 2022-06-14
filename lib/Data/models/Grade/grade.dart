// ignore_for_file: file_names
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Grade extends Equatable {
  Grade(
      {required this.id,
      this.score,
      this.aggregate, //needs to be removed
      required this.eventId,
      required this.player,
      required this.scoutId});

  int id;
  var score;
  var aggregate;
  final int eventId;
  final int player;
  final int scoutId;

  @override
  List<Object?> get props => [id, score, eventId, player, scoutId];

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        id: json['id'],
        score: json['score'],
        eventId: json['event'],
        scoutId: json['scout'],
        player: json['player'],
        aggregate: json['aggregate'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['score'] = score;
    data['event'] = eventId;
    data['scout'] = scoutId;
    data['player'] = player;
    data['aggregate'] = 10;

    return data;
  }

  @override
  String toString() =>
      "Grade { eventId: $eventId, Player $player vs score $score}";
}
