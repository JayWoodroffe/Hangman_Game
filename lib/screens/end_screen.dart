// ignore_for_file: prefer_const_constructors

import "package:audioplayers/audioplayers.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hangmanapp/screens/game_screen.dart";
import "package:hangmanapp/utils.dart";

class EndScreen extends StatefulWidget {
  final bool won;
  final String word;
  final bool soundOn;
  const EndScreen({super.key, required this.won, required this.word, required this.soundOn});

  @override
  State<EndScreen> createState() => _EndScreenState();
}

class _EndScreenState extends State<EndScreen> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playSound("endScreen.mp3");
  }

  _playSound(String sound) async {
    print(sound);
    player.setVolume(1.0);
    await player.play(AssetSource("sounds/$sound"));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);

    return Scaffold(
      backgroundColor: Colors.black45,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            Opacity(
              opacity: 0.5,
              child: Text(widget.won ? "You won" : "Game over",
                  style: TextStyle(
                      fontFamily: "Jacquard12",
                      color: Colors.red.shade900,
                      fontSize: 50,
                      height: 1)),
            ),
            Opacity(
              opacity: 0.5,
              child: Image(
                image: AssetImage("resources/images/bat.png"),
                color: Colors.red.shade900,
                height: 250,
                width: 300,
              ),
            ),
            widget.won
                ? SizedBox(height: 20)
                : Column(
                    children: [
                      Text(
                        "The word was:",
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                      Text(
                        widget.word,
                        style: gothicTextStyle(30, Colors.white),
                      )
                    ],
                  ),
            Opacity(
              opacity: 0.8,
              child: TextButton(
                  style: TextButton.styleFrom(
                      elevation: 0, backgroundColor: Colors.red.shade900),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GameScreen())),
                  child: Text(
                    "Play again",
                    style: gothicTextStyle(30, Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
