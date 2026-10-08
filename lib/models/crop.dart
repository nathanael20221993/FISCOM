import 'farm_entity.dart';

enum CropStatus { planned, growing, harvested }

class Crop implements FarmEntity {
  const Crop({
    this.id,
    required this.name,
    this.variety = '',
    this.plot = '',
    this.areaHa = 0,
    required this.plantingDate,
    this.expectedHarvestDate,
    this.status = CropStatus.growing,
    this.notes = '',
  });

  @override
  final String? id;
  final String name;
  final String variety;
  final String plot;
  final double areaHa;
  final DateTime plantingDate;
  final DateTime? expectedHarvestDate;
  final CropStatus status;
  final String notes;

  factory Crop.fromMap(String id, Map<String, dynamic> data) => Crop(
    id: id,
    name: data['name'] as String? ?? '',
    variety: data['variety'] as String? ?? '',
    plot: data['plot'] as String? ?? '',
    areaHa: doubleFromFirestore(data['areaHa']),
    plantingDate: dateFromFirestore(data['plantingDate']) ?? DateTime(2000),
    expectedHarvestDate: dateFromFirestore(data['expectedHarvestDate']),
    status: enumFromName(CropStatus.values, data['status'], CropStatus.growing),
    notes: data['notes'] as String? ?? '',
  );

  @override
  Map<String, dynamic> toMap() => {
    'name': name,
    'variety': variety,
    'plot': plot,
    'areaHa': areaHa,
    'plantingDate': dateToFirestore(plantingDate),
    'expectedHarvestDate': dateToFirestore(expectedHarvestDate),
    'status': status.name,
    'notes': notes,
  };
}
