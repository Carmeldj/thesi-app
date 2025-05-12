part of 'stream_cubit.dart';

@immutable
sealed class StreamState {}

final class StreamInitial extends StreamState {}

final class StreamLoading extends StreamState {}

final class StreamSucess extends StreamState {}

final class StreamFailure extends StreamState {
  final String error;

  StreamFailure(this.error);
}
