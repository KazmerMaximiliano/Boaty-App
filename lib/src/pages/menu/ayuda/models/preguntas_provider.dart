import 'package:boaty/src/pages/menu/ayuda/models/pregunta.dart';

class PreguntasProvider {
  static List<Pregunta> get userQuestions => [
        Pregunta(
            question: "¿Cómo hablo con el propietario del bote?",
            answer:
                "Una vez realizada la reserva llega un mail al inquilino con los datos de contacto del dueño. A su vez se le podría ofrecer un chat interno en la app (nose que tan complicado es integrar eso)"),
        Pregunta(
            question: "¿El bote está asegurado por cualquier cosa que ocurra?",
            answer:
                "Si, hay que definir si el seguro va a ser obligatorio y se incluirá en la tarifa final como un extra o si se ofrecerán varias opciones de seguros a contratar"),
        Pregunta(
            question:
                "¿Qué pasa si veo el bote y no está en las mismas condiciones que en las imágenes?",
            answer:
                "La idea sería que algún miembro de Boaty pueda ver y aprobar antes la embarcación para evitar fraudes y asegurarse que este todo igual que como lo publica el dueño. Puede hacerlo de forma presencial o con un período de evaluación por videollamada o email luego de que el anfitrión suba la imágenes y cree por primera vez la publicación")
      ];

  static List<Pregunta> get adminQuestions => [
        Pregunta(
            question: "¿Cuál es la comisión por poner mi bote en alquiler?",
            answer:
                "La comisión es del 1% para poder mantener la app y brindar atención las 24hs"),
        Pregunta(
            question: "¿Cómo me aseguro de que mi bote vaya a cuidarse?",
            answer: "Fianza y seguro"),
        Pregunta(
            question:
                "¿Quién cubre los gastos en caso de producirse algún daño?",
            answer:
                "Fianza y gastos extras en caso de que la fianza no lo cubra"),
        Pregunta(
            question:
                "¿Cómo se que la persona que va a alquilar mi barco es de confianza?",
            answer:
                "Se le puede hacer una evaluación con unas breves preguntas Múltiple choice para sacar info y conocerlo brevemente antes de entregarle la embarcación.\nA su vez tanto el usuario cliente como el anfitrión tendrán su perfil en el cual al finalizar la experiencia recibirán evaluación, creando así su reputación")
      ];
}
