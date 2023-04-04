import 'dart:convert';

class GamePlayer {
  int? gameId;
  int? playerId;
  DateTime? createdDate;
  DateTime? updatedDate;
  GamePlayer({
    this.gameId,
    this.playerId,
    this.createdDate,
    this.updatedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'game_id': gameId,
      'player_id': playerId,
      'created_date': createdDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'updated_date': DateTime.now().toIso8601String(),
    };
  }

  factory GamePlayer.fromMap(Map<String, dynamic> map) {
    return GamePlayer(
      gameId: map['game_id']?.toInt() ?? 0,
      playerId: map['player_id']?.toInt() ?? 0,
      createdDate: map['created_date'] != null ? DateTime.parse(map['created_date']) : null,
      updatedDate: map['updated_date'] != null ? DateTime.parse(map['updated_date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GamePlayer.fromJson(String source) => GamePlayer.fromMap(json.decode(source));
}
