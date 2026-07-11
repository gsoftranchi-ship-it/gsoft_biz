abstract class BaseFirestoreDataSource<T> {
  Future<void> create(
      String gymId,
      T model,
      );

  Future<void> update(
      String gymId,
      T model,
      );

  Future<T?> get(
      String gymId,
      String id,
      );

  Future<List<T>> getAll(
      String gymId,
      );

  Future<void> softDelete(
      String gymId,
      String id,
      );
}