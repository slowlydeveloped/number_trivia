import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/features/number_trivia/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failures, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failures, NumberTrivia>> getRandomNumberTrivia();
}
