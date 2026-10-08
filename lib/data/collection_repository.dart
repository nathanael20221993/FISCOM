import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/farm_entity.dart';

/// CRUD access to one Firestore collection of [T].
class CollectionRepository<T extends FarmEntity> {
  CollectionRepository(
    this._collection,
    this._fromMap, {
    required this.orderBy,
    this.descending = true,
  });

  final CollectionReference<Map<String, dynamic>> _collection;
  final T Function(String id, Map<String, dynamic> data) _fromMap;
  final String orderBy;
  final bool descending;

  Stream<List<T>> watchAll() => _collection
      .orderBy(orderBy, descending: descending)
      .snapshots()
      .map((s) => s.docs.map((d) => _fromMap(d.id, d.data())).toList());

  /// Creates the document when [item] has no id, otherwise overwrites it.
  Future<void> save(T item) async {
    final data = item.toMap()..['updatedAt'] = FieldValue.serverTimestamp();
    if (item.id == null) {
      data['createdAt'] = FieldValue.serverTimestamp();
      await _collection.add(data);
    } else {
      await _collection.doc(item.id).set(data, SetOptions(merge: true));
    }
  }

  Future<void> delete(String id) => _collection.doc(id).delete();
}
