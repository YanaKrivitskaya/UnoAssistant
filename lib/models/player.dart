import 'dart:convert';


class Player {
  int? id;
  String name; 
  bool? isSelected;
  DateTime? createdDate;
  DateTime? updatedDate;
  Player({
    this.id,
    required this.name,
    this.isSelected,
    this.createdDate,
    this.updatedDate,
  });

  Player copyWith({
    int? id,
    String? name,
    bool? isSelected,
    DateTime? createdDate,
    DateTime? updatedDate,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,      
      'created_date': createdDate != null ? createdDate!.toIso8601String() : DateTime.now().toIso8601String(),
      'updated_Date': DateTime.now().toIso8601String(),
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      isSelected: map['isSelected'] ?? false,
      createdDate: DateTime.parse(map['created_date']),
      updatedDate: DateTime.parse(map['updated_date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Player(id: $id, name: $name, isSelected: $isSelected, createdDate: $createdDate, updatedDate: $updatedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Player &&
      other.id == id &&
      other.name == name &&
      other.isSelected == isSelected &&
      other.createdDate == createdDate &&
      other.updatedDate == updatedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      isSelected.hashCode ^
      createdDate.hashCode ^
      updatedDate.hashCode;
  }
}
