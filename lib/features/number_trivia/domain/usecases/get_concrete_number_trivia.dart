import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '/core/error/failures.dart';
import '/core/usecases/usecase.dart';
import '/features/number_trivia/domain/entities/number_trivia.dart';
import '/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia extends UseCase<NumberTrivia, Params>{
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failures, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}
class Params extends Equatable {
  final int number;

  const Params({required this.number});
  
  @override

  List<Object?> get props => [number];
}