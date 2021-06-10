import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamo/widgets/BotaoCustomizado.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                      "images/Capa.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    Text(
                        "Pra Sempre Com Você",
                      style: GoogleFonts.karla(fontSize: 30),
                    ),
                    Text(
                        "by David Kalil Braga",
                      style: GoogleFonts.karla(fontSize: 18, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top:10,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BotaoCustomizado(
                            texto: "Spotify",
                            icone: FontAwesomeIcons.spotify,
                            corIcone: Color(0xff1DB954),
                            //corTexto: Color(0xff1DB954),
                            onPressed: (){},
                          ),
                          BotaoCustomizado(
                            texto: "Apple",
                            icone: FontAwesomeIcons.apple,
                            corIcone: Colors.black,
                           // corTexto: Color(0xff555555),
                            onPressed: (){},
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:15,bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BotaoCustomizado(
                            texto: "Amazon",
                            icone: FontAwesomeIcons.amazon,
                            corIcone: Color(0xffFF9900),
                            onPressed: (){},
                          ),
                          BotaoCustomizado(
                            texto: "Deezer",
                            icone: FontAwesomeIcons.deezer,
                            corIcone: Colors.black87,
                            onPressed: (){},
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
