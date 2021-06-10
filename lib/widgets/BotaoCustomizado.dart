import 'package:flutter/material.dart';

class BotaoCustomizado extends StatelessWidget {

  final String texto;
  final Color corTexto;
  final Color corFundo;
  final Color corIcone;
  final IconData icone;
  final VoidCallback onPressed;

  BotaoCustomizado({
    @required this.texto,
    @required this.icone,
    this.corTexto = Colors.black38,
    this.corFundo = Colors.white,
    this.corIcone = Colors.black38,
    this.onPressed
});


  @override
  Widget build(BuildContext context) {
    return
        SizedBox(
          width: 170,
          height: 55,
          child: ElevatedButton.icon(
            icon: Icon(this.icone, color: this.corIcone, size: 24,),
            label: Text(
              this.texto,
              style: TextStyle(
                  color: this.corTexto, fontSize: 20
              ),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 3,
                primary: this.corFundo,
                padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)
                )
              //textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
            ),
            onPressed: this.onPressed,
          ),
        );
  }
}
