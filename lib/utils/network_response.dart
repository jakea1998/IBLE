class NetworkResponse<T> {
  bool? success;
  String? message;
  T? body;

  NetworkResponse({
    this.success,
    this.message,
    this.body,
  });
}
