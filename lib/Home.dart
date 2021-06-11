import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamo/page_manager.dart';
import 'package:teamo/widgets/BotaoCustomizado.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageManager _pageManager;

  @override
  void initState() {

    super.initState();
    _pageManager = PageManager();


  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

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
                  padding: EdgeInsets.only(top: 64,bottom: 32),
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
