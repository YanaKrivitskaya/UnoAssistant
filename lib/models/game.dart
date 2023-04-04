import 'dart:convert';


class Game {
  int? id;
  int? scoreToWin;
  DateTime? startDate;
  DateTime? endDate;
  int? winnerId;
  int? winnerScore;
  DateTime? createdDate;
  DateTime? updatedDate;

  Game({
    this.id,
    this.scoreToWin,
    this.startDate,
    this.endDate,
    this.winnerId,
    this.winnerScore,
    this.createdDate,
    this.updatedDate,
  });

  Game copyWith({
    int? id,
    int? scoreToWin,
    DateTime? startDate,
    DateTime? endDate,
    int? winnerId,
    int? winnerScore,
    DateTime? createdDate,
    DateTime? updatedDate,
  }) {
    return Game(
      id: id ?? this.id,
      scoreToWin: scoreToWin ?? this.scoreToWin,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      winnerId: winnerId ?? this.winnerId,
      winnerScore: winnerScore ?? this.winnerScore,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score_to_win': scoreToWin,
      'start_date': DateTime.now().toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'winner_id': winnerId,
      'winner_score': winnerScore,
      'created_date': createdDate != null ? createdDate!.toIso8601String() : DateTime.now().toIso8601String(),
      'updated_date': DateTime.now().toIso8601String(),
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id']?.toInt() ?? 0,
      scoreToWin: map['score_to_win']?.toInt() ?? 0,
      startDate: DateTime.parse(map['start_date']),
      endDate: map['end_date'] != null ? DateTime.parse(map['end_date']) : null,
      winnerId: map['winner_id']?.toInt(),
      winnerScore: map['winner_score']?.toInt(),
      createdDate: DateTime.parse(map['created_date']),
      updatedDate: DateTime.parse(map['updated_date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Game.fromJson(String source) => Game.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Game(id: $id, scoreToWin: $scoreToWin, startDate: $startDate, endDate: $endDate, winnerId: $winnerId, winnerScore: $winnerScore, createdDate: $createdDate, updatedDate: $updatedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Game &&
      other.id == id &&
      other.scoreToWin == scoreToWin &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.winnerId == winnerId &&
      other.winnerScore == winnerScore &&
      other.createdDate == createdDate &&
      other.updatedDate == updatedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      scoreToWin.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      winnerId.hashCode ^
      winnerScore.hashCode ^
      createdDate.hashCode ^
      updatedDate.hashCode;
  }
}
