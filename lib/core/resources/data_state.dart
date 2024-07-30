import 'package:dio/dio.dart';

/// Represents the state of data fetched from an API.
///
/// This abstract class is used as a base for successful and failed data states.
abstract class DataState<T> {
  /// The data returned by the API, if the call was successful.
  final T? data;

  /// The error that occurred during the API call, if any.
  final DioException? error;

  /// Creates a new [DataState] instance.
  ///
  /// Either [data] or [error] can be provided, but not both.
  const DataState({this.data, this.error});
}

/// Represents a successful data fetch operation.
class DataSuccess<T> extends DataState<T> {
  /// Creates a new [DataSuccess] instance with the provided [data].
  const DataSuccess(T data) : super(data: data);
}

/// Represents a failed data fetch operation.
class DataFailed<T> extends DataState<T> {
  /// Creates a new [DataFailed] instance with the provided [error].
  const DataFailed(DioException error) : super(error: error);
}

///alternative we can use Either from dartz package,