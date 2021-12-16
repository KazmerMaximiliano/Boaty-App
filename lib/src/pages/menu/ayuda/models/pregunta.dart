class Pregunta {
  final String question;
  final String answer;
  bool expanded;

  Pregunta({
    required this.question,
    required this.answer,
    this.expanded = false,
  });
}
