import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';

class InputConverter {
  Either<Failures, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failures {
  @override
  List<Object?> get props => throw UnimplementedError();
}
