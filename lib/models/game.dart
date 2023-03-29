import 'dart:convert';


class Game {
  int id;
  int scoreToWin;
  DateTime startDate;
  DateTime? endDate;
  int? winnerId;
  int? winnerScore;
  DateTime createdDate;
  DateTime updatedDate;

  Game({
    required this.id,
    required this.scoreToWin,
    required this.startDate,
    this.endDate,
    this.winnerId,
    this.winnerScore,
    required this.createdDate,
    required this.updatedDate,
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
      'scoreToWin': scoreToWin,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'winnerId': winnerId,
      'winnerScore': winnerScore,
      'createdDate': createdDate.toIso8601String(),
      'updatedDate': updatedDate.toIso8601String(),
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id']?.toInt() ?? 0,
      scoreToWin: map['scoreToWin']?.toInt() ?? 0,
      startDate: DateTime.parse(map['startDate']),
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      winnerId: map['winnerId']?.toInt(),
      winnerScore: map['winnerScore']?.toInt(),
      createdDate: DateTime.parse(map['createdDate']),
      updatedDate: DateTime.parse(map['updatedDate']),
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
