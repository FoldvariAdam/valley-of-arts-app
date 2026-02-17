import 'package:isar_community/isar.dart';

abstract class IsarHelper<T> {
  final Isar isar;

  IsarHelper(this.isar);

  Isar getIsar() => isar;

  IsarCollection<T> get collection => isar.collection<T>();

  // ---------------------------
  // TRANSACTION HELPERS
  // ---------------------------

  R runSyncTxn<R>(R Function() action) {
    return isar.writeTxnSync<R>(() => action());
  }

  Future<R> runAsyncTxn<R>(Future<R> Function() action) {
    return isar.writeTxn<R>(() => action());
  }

  // ---------------------------
  // SYNC CRUD
  // ---------------------------

  // Helper (own transaction)
  void saveSync(T item) => runSyncTxn(() => collection.putSync(item));

  void saveManySync(List<T> items) =>
      runSyncTxn(() => collection.putAllSync(items));

  bool deleteSync(Id id) => runSyncTxn(() => collection.deleteSync(id));

  void deleteAllSync() => runSyncTxn(() => collection.clearSync());

  // Base (no txn)
  void saveSyncNoTxn(T item) => collection.putSync(item);

  void saveManySyncNoTxn(List<T> items) => collection.putAllSync(items);

  bool deleteSyncNoTxn(Id id) => collection.deleteSync(id);

  void deleteAllSyncNoTxn() => collection.clearSync();

  // Reads (no txn needed)
  List<T> getAllSync() => collection.where().findAllSync();

  T? getByIdSync(Id id) => collection.getSync(id);

  int countSync() => collection.countSync();

  // ---------------------------
  // ASYNC CRUD
  // ---------------------------

  // Helper (own transaction)
  Future<void> save(T item) => runAsyncTxn(() => collection.put(item));

  Future<void> saveMany(List<T> items) =>
      runAsyncTxn(() => collection.putAll(items));

  Future<bool> delete(Id id) => runAsyncTxn(() => collection.delete(id));

  Future<void> deleteAll() => runAsyncTxn(() => collection.clear());

  // Base (no transaction)
  Future<void> saveNoTxn(T item) => collection.put(item);

  Future<void> saveManyNoTxn(List<T> items) => collection.putAll(items);

  Future<bool> deleteNoTxn(Id id) => collection.delete(id);

  Future<void> deleteAllNoTxn() => collection.clear();

  // Reads (async)
  Future<List<T>> getAll() => collection.where().findAll();

  Future<T?> getById(Id id) => collection.get(id);

  Future<int> count() => collection.count();

  // ---------------------------
  // WATCH / STREAMS
  // ---------------------------

  Stream<List<T>> watchAll({bool fireImmediately = false}) =>
      collection.where().watch(fireImmediately: fireImmediately);

  Stream<T?> watchById(Id id, {bool fireImmediately = false}) =>
      collection.watchObject(id, fireImmediately: fireImmediately);
}
