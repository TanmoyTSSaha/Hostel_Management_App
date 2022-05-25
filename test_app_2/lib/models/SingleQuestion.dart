import '../Providers/Option.dart';
class SingleQuestion{
  final String id;

  final String question;
  final List<Option>options;
  int selectedOptionIndex;
  SingleQuestion({ this.id,  this.question, this.options ,this.selectedOptionIndex});
}