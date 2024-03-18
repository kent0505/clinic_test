import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String error;
  final String stack;
  const ServerException({
    required this.error,
    required this.stack,
  });
  @override
  List<Object?> get props => [error, stack];
}
