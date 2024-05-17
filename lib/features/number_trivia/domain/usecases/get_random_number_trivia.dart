import 'package:dartz/dartz.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/number_trivia/domain/entities/number_trivia.dart';
import '/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
   Future<Either<Failures, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
  
}
