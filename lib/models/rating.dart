import 'dart:convert';

class Rating {
  final String userId;
  final double rating;

  // Constructor to initialize rating properties
  Rating({
    required this.userId,
    required this.rating,
  });

  // Convert rating object to a map for serialization
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
    };
  }

  // Factory constructor to create a rating object from a map
  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  // Convert rating object to JSON
  String toJson() => json.encode(toMap());

  // Factory constructor to create a rating object from JSON string
  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}
