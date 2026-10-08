import 'farm_entity.dart';

/// A group of animals managed together (a flock, a herd, a pond…).
class AnimalBatch implements FarmEntity {
  const AnimalBatch({
    this.id,
    required this.species,
    this.name = '',
    this.headcount = 0,
    this.breed = '',
    required this.acquiredDate,
    this.notes = '',
  });

  @override
  final String? id;
  final String species;
  final String name;
  final int headcount;
  final String breed;
  final DateTime acquiredDate;
  final String notes;

  factory AnimalBatch.fromMap(String id, Map<String, dynamic> data) =>
      AnimalBatch(
        id: id,
        species: data['species'] as String? ?? '',
        name: data['name'] as String? ?? '',
        headcount: (data['headcount'] as num?)?.toInt() ?? 0,
        breed: data['breed'] as String? ?? '',
        acquiredDate: dateFromFirestore(data['acquiredDate']) ?? DateTime(2000),
        notes: data['notes'] as String? ?? '',
      );

  @override
  Map<String, dynamic> toMap() => {
    'species': species,
    'name': name,
    'headcount': headcount,
    'breed': breed,
    'acquiredDate': dateToFirestore(acquiredDate),
    'notes': notes,
  };
}
