import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ntjfarm/data/farm_repository.dart';
import 'package:ntjfarm/models/stock_item.dart';

void main() {
  test('create, update and delete are scoped to the user', () async {
    final db = FakeFirebaseFirestore();
    final repo = FarmRepository(db, 'user-1');

    await repo.stock.save(const StockItem(name: 'Semences', quantity: 10));
    await repo.stock.save(const StockItem(name: 'Engrais', quantity: 4));

    var items = await repo.stock.watchAll().first;
    expect(items.map((i) => i.name), ['Engrais', 'Semences']);

    final engrais = items.first;
    await repo.stock.save(
      StockItem(
        id: engrais.id,
        name: engrais.name,
        quantity: 2,
        minQuantity: 3,
      ),
    );
    items = await repo.stock.watchAll().first;
    expect(items.first.quantity, 2);
    expect(items.first.isLow, isTrue);

    await repo.stock.delete(engrais.id!);
    items = await repo.stock.watchAll().first;
    expect(items.map((i) => i.name), ['Semences']);

    // Another user sees nothing.
    expect(await FarmRepository(db, 'user-2').stock.watchAll().first, isEmpty);
    final raw = await db.collection('users/user-1/stock').get();
    expect(raw.docs, hasLength(1));
  });
}
