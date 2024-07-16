import 'package:flutter/material.dart';

/// O parâmetro [context] é obrigatório e representa o contexto de construção do widget que chama essa função.
///
/// O parâmetro [title] é opcional e tem o valor padrão "Atenção!". Ele representa o título do diálogo.
///
/// O parâmetro [content] é opcional e tem o valor padrão "Você realmente deseja executar essa operação?". Ele representa o conteúdo do diálogo.
///
/// O parâmetro [affirmativeOption] é opcional e tem o valor padrão "Confirmar". Ele representa o texto do botão afirmativo.
///
/// O parâmetro [negativeOption] é opcional e tem o valor padrão "Cancelar". Ele representa o texto do botão negativo.
///
///O parâmetro [affirmativeOtionColor] é opcional e tem o valor padrão `Colors.green`. Ele representa a cor do botão afirmativo.
///
// Exemplo de uso:
/*
showConfirmationDialog(
  context,
  title: "Confirmação",
  content: "Deseja realmente excluir esse item?",
  affirmativeOption: "Excluir",
  affirmativeOptionColor: Colors.red,
  negativeOption: "Cancelar",
  negativeOptionColor: Colors.blue,
).then((confirmed) {
  if (confirmed) {
    ///Se confirmado, executa a ação de exclusão
  } else {
    ///Se cancelado, não faz nada ou exibe uma mensagem
  }
});
*/

Future<dynamic> showConfirmationDialog(
  BuildContext context, {
  String title = "Atenção!",
  String content = "Você realmente deseja executar essa operação?",
  String affirmativeOption = "Confirmar",
  String negativeOption = "Cancelar",
  Color affirmativeOptionColor = Colors.green,
  Color negativeOptionColor = Colors.red,
  Color dialogBackgroundColor = Colors.white,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: dialogBackgroundColor,
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(
              negativeOption,
              style: TextStyle(color: negativeOptionColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              affirmativeOption.toUpperCase(),
              style: TextStyle(
                color: affirmativeOptionColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
