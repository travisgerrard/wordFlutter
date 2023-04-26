// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Word {
  final String id;
  final String word;
  final num percentCorrect;
  final bool isLearning;
  Word({
    required this.id,
    required this.word,
    required this.percentCorrect,
    required this.isLearning,
  });

  Word copyWith({
    String? id,
    String? word,
    num? percentCorrect,
    bool? isLearning,
  }) {
    return Word(
      id: id ?? this.id,
      word: word ?? this.word,
      percentCorrect: percentCorrect ?? this.percentCorrect,
      isLearning: isLearning ?? this.isLearning,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'word': word,
      'percentCorrect': percentCorrect,
      'isLearning': isLearning,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['_id'] as String,
      word: map['word'] as String,
      percentCorrect: map['percentCorrect'] as num,
      isLearning: map['isLearning'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Word.fromJson(String source) =>
      Word.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Word(id: $id, word: $word, percentCorrect: $percentCorrect, isLearning: $isLearning)';
  }

  @override
  bool operator ==(covariant Word other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.word == word &&
        other.percentCorrect == percentCorrect &&
        other.isLearning == isLearning;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        word.hashCode ^
        percentCorrect.hashCode ^
        isLearning.hashCode;
  }
}
