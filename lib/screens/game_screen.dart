import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hangmanapp/utils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int lives = 7;

  //randomly selecting a word from the list
  String word = wordsList[Random().nextInt(wordsList.length)];

  //generate row of hearts
  Widget _buildLivesDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        lives,
        (index) => const Padding(
          padding: EdgeInsets.only(
            left: 15,
          ),
          child: Image(
            width: 30,
            height: 20,
            image: AssetImage("resources/images/heart.png"),
          ),
        ),
      ),
    );
  }

  //managing how the semi-guessed word is displayed
  String _handleText() {
    String displayedWord = "";
    List guessedLetters = [];
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (guessedLetters.contains(char)) {
        displayedWord += "$char ";
      } else {
        displayedWord += '_ ';
      }
    }
    return displayedWord;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //header
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: IconButton(
                icon: Icon(
                  size: 35,
                  color: Colors.red.shade900,
                  Icons.volume_up_rounded,
                ),
                onPressed: () {}),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.black45,
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            "hangman",
            style: gothicTextStyle(50, Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.black45,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              //points display
              Container(
                decoration: BoxDecoration(color: Colors.red.shade900),
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width / 3.5,
                height: 35,
                child: Center(
                    child: Text("12 points",
                        style: gothicTextStyle(
                            24, Colors.black, FontWeight.w300))),
              ),

              SizedBox(height: 20),

              //hangman image
              Image(
                width: 155,
                height: 155,
                image: AssetImage("resources/images/hangman0.png"),
                fit: BoxFit.cover,
                color: Colors.white,
              ),

              SizedBox(height: 25),

              //lives left
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _buildLivesDisplay()),

              SizedBox(height: 10),

              //the word
              Text(
                _handleText(),
                style: gothicTextStyle(45, Colors.white),
              ),

              //keyboard
              GridView.count(
                padding: EdgeInsets.only(left: 15),
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: letters.map((alphabet) {
                  return InkWell(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          alphabet,
                          style: gothicTextStyle(35, Colors.white),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
