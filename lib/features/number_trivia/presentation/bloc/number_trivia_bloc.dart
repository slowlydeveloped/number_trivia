
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/core/utils/input_converter.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetTriviaForConcreteNumber>(getTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(getTriviaForRandomNumber);
  }

//   Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event) async* {
//     if (event is GetTriviaForConcreteNumber) {
//       final inputEither =
//           inputConverter.stringToUnsignedInteger(event.numberString);
//       yield* inputEither.fold((failure) async* {
//         yield const Error(message: INVALID_INPUT_FAILURE_MESSAGE);
//       }, (integer) async* {
//         yield Loading();
//         final failureOrTrivia =
//             await getConcreteNumberTrivia(Params(number: integer));

//         yield* _eitherLoadedOrErrorState(failureOrTrivia);
//       });
//     } else if (event is GetTriviaForRandomNumber) {
//       yield Loading();
//       final failureOrTrivia = await getRandomNumberTrivia(
//         NoParams(),
//       );
//       yield* _eitherLoadedOrErrorState(failureOrTrivia);
//     }
//   }

//   Stream<NumberTriviaState> _eitherLoadedOrErrorState(
//     Either<Failures, NumberTrivia> failureOrTrivia,
//   ) async* {
//     yield failureOrTrivia.fold(
//       (failure) => Error(message: _mapFailureToMessage(failure)),
//       (trivia) => Loaded(trivia: trivia),
//     );
//   }
// }

// String _mapFailureToMessage(Failures failure) {
//   switch (failure.runtimeType) {
//     case ServerFailure:
//       return SERVER_FAILURE_MESSAGE;
//     case CachedFailure:
//       return CACHE_FAILURE_MESSAGE;
//     default:
//       return 'Unexpected Error';
//   }

  FutureOr<void> getTriviaForConcreteNumber(
      GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit) async {
    final inputEither =
        inputConverter.stringToUnsignedInteger(event.numberString);
    await inputEither.fold((failure) async {
      emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE));
    }, (integer) async {
      emit(Empty());
      emit(Loading());
      final failureOrSuccess =
          await getConcreteNumberTrivia(Params(number: integer));
      await failureOrSuccess.fold(
        (failure) async {
          emit(Error(message: _mapFailureToMessage(failure)));
        },
        (trivia) async {
          emit(Loaded(trivia: trivia));
        },
      );
    });
  }

  FutureOr<void> getTriviaForRandomNumber(
      GetTriviaForRandomNumber event, Emitter<NumberTriviaState> emit) async {
    emit(Loading());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());
    failureOrTrivia.fold(
      (failure) async {
        emit(Error(message: _mapFailureToMessage(failure)));
      },
      (trivia) async {
        emit(Loaded(trivia: trivia));
      },
    );
  }

  String _mapFailureToMessage(Failures failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CachedFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
