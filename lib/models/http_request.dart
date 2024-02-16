abstract class HTTPRequest<T> {
  Future<List<T>> execute();
}
