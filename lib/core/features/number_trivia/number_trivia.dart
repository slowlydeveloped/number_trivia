import 'package:equatable/equatable.dart';


abstract class NumberTrivia extends Equatable {
  final String text;
  final int number;

  const NumberTrivia({required this.text, required this.number});
  
}
