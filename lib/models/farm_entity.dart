import 'package:cloud_firestore/cloud_firestore.dart';

/// Base for every document stored under `users/{uid}/...` in Firestore.
abstract class FarmEntity {
  String? get id;

  Map<String, dynamic> toMap();
}

DateTime? dateFromFirestore(Object? value) =>
    value is Timestamp ? value.toDate() : null;

Timestamp? dateToFirestore(DateTime? value) =>
    value == null ? null : Timestamp.fromDate(value);

double doubleFromFirestore(Object? value) =>
    value is num ? value.toDouble() : 0;

/// Looks up an enum value by name, falling back to [fallback] for unknown or
/// missing values so that older/newer app versions never crash on read.
T enumFromName<T extends Enum>(List<T> values, Object? name, T fallback) {
  for (final v in values) {
    if (v.name == name) return v;
  }
  return fallback;
}
