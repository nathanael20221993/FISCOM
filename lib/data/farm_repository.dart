import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/animal_batch.dart';
import '../models/crop.dart';
import '../models/farm_transaction.dart';
import '../models/stock_item.dart';
import 'collection_repository.dart';

/// All the farm data of one user, stored under `users/{uid}/...`.
class FarmRepository {
  FarmRepository(FirebaseFirestore db, String uid)
    : _user = db.collection('users').doc(uid);

  final DocumentReference<Map<String, dynamic>> _user;

  late final crops = CollectionRepository<Crop>(
    _user.collection('crops'),
    Crop.fromMap,
    orderBy: 'plantingDate',
  );

  late final animals = CollectionRepository<AnimalBatch>(
    _user.collection('animals'),
    AnimalBatch.fromMap,
    orderBy: 'acquiredDate',
  );

  late final stock = CollectionRepository<StockItem>(
    _user.collection('stock'),
    StockItem.fromMap,
    orderBy: 'name',
    descending: false,
  );

  late final transactions = CollectionRepository<FarmTransaction>(
    _user.collection('transactions'),
    FarmTransaction.fromMap,
    orderBy: 'date',
  );
}
