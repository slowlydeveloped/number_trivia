import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

abstract class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
    
  // @override
  // Future<Either<Failures, NumberTrivia>> getConcreteNumberTrivia(int number) {
  //   // TODO: implement getConcreteNumberTrivia
  //   return null;
  // }

  // @override
  // Future<Either<Failures, NumberTrivia>> getRandomNumberTrivia() {
  //   // TODO: implement getRandomNumberTrivia
  //   return null;
  // }
}