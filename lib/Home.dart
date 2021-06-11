import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamo/page_manager.dart';
import 'package:teamo/widgets/BotaoCustomizado.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageManager _pageManager;
  bool _habilitaHome = false;
  bool _habilitaLink = false;
  int _days = 0;
  int _hours = 0;
  int _minutes = 0;
  int _totalminutes = 0;
  String _textoD = "";
  String _textoH = "";
  String _textoM = "";
  String _urlSpotify = "";
  String _urlApple = "";
  String _urlAmazon = "";
  String _urlDeezer = "";

  _countdown(){
    DateTime horaSurpresa = DateTime.parse('2021-06-12').toLocal();
    DateTime agora = DateTime.now();
    Duration dur = horaSurpresa.toLocal().difference(agora);
    print("agora: " +agora.toLocal().toString());
    print("Dias:" + dur.inDays.toString());
    print("Horas:" + dur.inHours.toString());
    print("minutos:" + dur.inMinutes.toString());


    int dias;
    int horas;
    int minutos;
    int minutostotais;

    minutostotais = dur.inMinutes;

    String tdias;
    String thoras;
    String tminutos;

    dias = dur.inDays;
    horas = dur.inHours - (dias*24);
    minutos = dur.inMinutes - (dur.inDays*24*60) - (horas*60);

    if(dias<=1){
      tdias = "dia";
    }else{
      tdias = "dias";
    }

    if(horas<=1){
      thoras = "hora";
    }else{
      thoras = "horas";
    }

    if(minutos<=1){
      tminutos= "minuto";
    }else{
      tminutos = "minutos";
    }

    print("Dias:" + dias.toString());
    print("Horas:" + horas.toString());
    print("minutos:" + minutos.toString());

    setState(() {
      _days = dias;
      _hours = horas;
      _minutes = minutos;
      _totalminutes = minutostotais;
      _textoD = tdias;
      _textoH = thoras;
      _textoM = tminutos;
    });

  }

  _checarHabilitacao() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    //Unica consulta, pega dados, processo encerrado
    DocumentSnapshot snapshot =
        await db.collection("links").doc("habilitar").get();

    Map<String, dynamic>? dados = snapshot.data();

    print("home status");
    print(dados!["homepage"]);
    print("link status");
    print(dados!["streaming"]);
    bool habilitaHome = dados["homepage"].toString() == "true" ? true : false;
    bool habilitaLink = dados["streaming"].toString() == "true" ? true : false;

    setState(() {
      _habilitaHome = habilitaHome;
      _habilitaLink = habilitaLink;
    });

    _carregarlinks();
  }

  _carregarlinks() async{
    FirebaseFirestore db = FirebaseFirestore.instance;

    //Unica consulta, pega dados, processo encerrado
    DocumentSnapshot snapshot =
    await db.collection("links").doc("streaming").get();

    Map<String, dynamic>? dados = snapshot.data();

    print("spotify");
    print(dados!["spotify"]);
    print("apple");
    print(dados!["applemusic"]);
    print("amazon");
    print(dados!["amazonmusic"]);
    print("deezer");
    print(dados!["deezer"]);

    //Atribuir links aos botoes

      setState(() {
        _urlSpotify = dados!["spotify"];
        _urlApple = dados!["applemusic"];
        _urlAmazon = dados!["amazonmusic"];
        _urlDeezer = dados!["deezer"];
      });

  }

  _chamarURL(String url)async{

    if(await canLaunch(url)){
      await launch(url);
    }else{
      print("Não pode chamar url!");
    }
  }

  @override
  void initState() {
    _countdown();
    _checarHabilitacao();
    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _habilitaHome
        ? Scaffold(
            body: Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 64, bottom: 32),
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
                            style: GoogleFonts.karla(
                                fontSize: 18, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ValueListenableBuilder<ButtonState>(
                            valueListenable: _pageManager.buttonNotifier,
                            builder: (_, value, __) {
                              switch (value) {
                                case ButtonState.loading:
                                  return Container(
                                    margin: EdgeInsets.all(8.0),
                                    width: 32.0,
                                    height: 32.0,
                                    child: CircularProgressIndicator(),
                                  );
                                case ButtonState.paused:
                                  return IconButton(
                                    icon: Icon(FontAwesomeIcons.playCircle),
                                    iconSize: 32.0,
                                    onPressed: _pageManager.play,
                                  );
                                case ButtonState.playing:
                                  return IconButton(
                                    icon: Icon(FontAwesomeIcons.pauseCircle),
                                    iconSize: 32.0,
                                    onPressed: _pageManager.pause,
                                  );
                              }
                            },
                          ),
                          ValueListenableBuilder<ProgressBarState>(
                            valueListenable: _pageManager.progressNotifier,
                            builder: (_, value, __) {
                              return ProgressBar(
                                baseBarColor: Color(0xffcccccd),
                                bufferedBarColor: Color(0xffb2b2b4),
                                progressBarColor: Color(0xff000005),
                                thumbColor: Colors.black87,
                                progress: value.current,
                                buffered: value.buffered,
                                total: value.total,
                                onSeek: _pageManager.seek,
                              );
                            },
                          ),
                        ],
                      ),
                      _habilitaLink?
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BotaoCustomizado(
                                  texto: "Spotify",
                                  icone: FontAwesomeIcons.spotify,
                                  corIcone: Color(0xff1DB954),
                                  //corTexto: Color(0xff1DB954),
                                  onPressed: () {
                                    _chamarURL(_urlSpotify);
                                  },
                                ),
                                BotaoCustomizado(
                                  texto: "Apple",
                                  icone: FontAwesomeIcons.apple,
                                  corIcone: Colors.black,
                                  // corTexto: Color(0xff555555),
                                  onPressed: () {
                                    _chamarURL(_urlApple);
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BotaoCustomizado(
                                  texto: "Amazon",
                                  icone: FontAwesomeIcons.amazon,
                                  corIcone: Color(0xffFF9900),
                                  onPressed: () {
                                    _chamarURL(_urlAmazon);
                                  },
                                ),
                                BotaoCustomizado(
                                  texto: "Deezer",
                                  icone: FontAwesomeIcons.deezer,
                                  corIcone: Colors.black87,
                                  onPressed: () {
                                    _chamarURL(_urlDeezer);
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
          )
        : Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 32),
                  child: Image.asset(
                    "images/batma.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                Text("OPS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text("Ainda não ta na hora da surpresa!", style: TextStyle(fontSize: 20)),
                Text("mocinha! 👆🏻", style: TextStyle(fontSize: 20)),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text("Tempo restante para a surpresa:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                _totalminutes <0? Text("CHEGOU! 😍", style: TextStyle(fontSize: 20, color: Colors.green)):
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _days >=1? Text("$_days $_textoD ", style: TextStyle(fontSize: 20)):Container(),
                    _hours>=1? Text("$_hours $_textoH ", style: TextStyle(fontSize: 20)):Container(),
                    _minutes>=1? Text("$_minutes $_textoM ", style: TextStyle(fontSize: 20)): Container(),
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
