import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  // если false, то сообщение не будет показано на экране
  // костыль, но у меня нет сейчас времени
  final bool seriously;

  const Failure({this.message='', this.seriously = true});

  @override
  List<Object> get props => [message];
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({required String message}) : super(message: message);
}



class ServerFailuer extends Failure {
  const ServerFailuer({required String message, seriously}) : super(message: message);
}

class UnAuthFailure extends Failure {
  const UnAuthFailure({required String message, seriously}) : super(message: message);
}


