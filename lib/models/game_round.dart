import 'dart:convert';


class GameRound {
  int? id;
  int? gameId;
  int? playerId;
  int? roundNumber;
  int? score;
  DateTime? createdDate;
  DateTime? updatedDate;
  GameRound({
    this.id,
    this.gameId,
    this.playerId,
    this.roundNumber,
    this.score,
    this.createdDate,
    this.updatedDate,
  });

  GameRound copyWith({
    int? id,
    int? gameId,
    int? playerId,
    int? roundNumber,
    int? score,
    DateTime? createdDate,
    DateTime? updatedDate,
  }) {
    return GameRound(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      playerId: playerId ?? this.playerId,
      roundNumber: roundNumber ?? this.roundNumber,
      score: score ?? this.score,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'game_id': gameId,
      'player_id': playerId,
      'round_number': roundNumber,
      'score': score,
      'created_date': createdDate != null ? createdDate!.toIso8601String() : DateTime.now().toIso8601String(),
      'updated_date': DateTime.now().toIso8601String(),
    };
  }

  factory GameRound.fromMap(Map<String, dynamic> map) {
    return GameRound(
      id: map['id']?.toInt(),
      gameId: map['game_id']?.toInt(),
      playerId: map['player_id']?.toInt(),
      roundNumber: map['round_number']?.toInt(),
      score: map['score']?.toInt(),
      createdDate: map['created_date'] != null ? DateTime.parse(map['created_date']) : null,
      updatedDate: map['updated_date'] != null ? DateTime.parse(map['updated_date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameRound.fromJson(String source) => GameRound.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GameRound(id: $id, gameId: $gameId, playerId: $playerId, roundNumber: $roundNumber, score: $score, createdDate: $createdDate, updatedDate: $updatedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GameRound &&
      other.id == id &&
      other.gameId == gameId &&
      other.playerId == playerId &&
      other.roundNumber == roundNumber &&
      other.score == score &&
      other.createdDate == createdDate &&
      other.updatedDate == updatedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      gameId.hashCode ^
      playerId.hashCode ^
      roundNumber.hashCode ^
      score.hashCode ^
      createdDate.hashCode ^
      updatedDate.hashCode;
  }
}
