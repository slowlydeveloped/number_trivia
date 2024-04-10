import 'package:equatable/equatable.dart';
abstract class Failures extends Equatable{
   const Failures([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failures{
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CachedFailure extends Failures{
  @override
  List<Object?> get props => throw UnimplementedError();
}