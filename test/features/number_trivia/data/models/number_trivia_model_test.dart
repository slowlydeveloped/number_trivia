import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(text: 'Test Text', number: 1);

  test('should be a subclass of NumberTriviaModel', () async {
    expect(tNumberTriviaModel, isA<NumberTriviaModel>());
  });

  group('from JSON', () {
    test('should return a valid model when the json number is an integer',
        () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });

    test('should return a valid model when the json number is an double',
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });
  });

  group('to JSON', () {
    test("should return a JSON map containing the proper data ", () async {
      final result = tNumberTriviaModel.toJson();

      final expectedJsonMap = {"text": "Test Text", "number": 1};
      expect(result, expectedJsonMap);
    });
  });
}
