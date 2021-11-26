abstract class CrudRepository<T,ID>{
  ///Returns [T] with the given [id].
  ///Returns null if an entity [T] with the given parameter does not exist
  Future<T> get(ID id);

  ///Inserts the given entity [T] into the database.
  ///Returns the new entity with a new [ID]
  ///@param [T] entity
  ///@throws [DatabaseException] on conflict.
  ///@return [Future]<[T]>
  Future<T> insert(T t);

  ///Inserts or updates the given entity [T]. Will never be null
  ///Throws [DatabaseException]
  Future<T> save(T t);
  Future<ID> delete(T t);
  Future<List<T>> getAll();
}