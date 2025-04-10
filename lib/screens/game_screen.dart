// ignore_for_file: prefer_const_constructors

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

  List guessedLetters = [];

  //randomly selecting a word from the list upon running
  String word = wordsList[Random().nextInt(wordsList.length)];

  //generate row of hearts
  Widget _buildLivesDisplay() {
    return Container(
      margin: EdgeInsets.only(left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          lives,
          (index) => const Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Image(
              width: 30,
              height: 20,
              image: AssetImage("resources/images/heart.png"),
            ),
          ),
        ),
      ),
    );
  }

  //managing how the semi-guessed word is displayed
  String _handleText() {
    String displayedWord = " ";

    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      //if the current character has been guessed already, it will be included in the guessedLetters list and can be displayed
      if (guessedLetters.contains(char)) {
        displayedWord += "$char ";
      } else {
        displayedWord += '_ ';
      }
    }
    return displayedWord;
  }

  _checkLetter(String letter) {
    if (word.contains(letter)) {
      setState(() {
        guessedLetters.add(letter);
      });
    } else {
      if (lives >= 1) {
        setState(() {
          guessedLetters.add(letter);
          lives--;
        });
      } else {
        print("You lost");
      }
    }
    bool wordCompleted = true;
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      if (!guessedLetters.contains(char)) {
        setState(() {
          wordCompleted = false;
        });
        break;
      }
      if (wordCompleted) {
        print("Won");
      }
    }
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
              //TODO: decide if points even make sense(tutorial gives 5 points for each correctly guessed letter??)
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: Colors.red.shade900,
              //         borderRadius: BorderRadius.circular(15)),
              //     margin: EdgeInsets.only(top: 20, left: 30),
              //     width: MediaQuery.of(context).size.width / 3.5,
              //     height: 35,
              //     child: Center(
              //         child: Text("12 points",
              //             style: gothicTextStyle(
              //                 24, Colors.black, FontWeight.w300))),
              //   ),
              // ),

              SizedBox(height: 40),

              //hangman image
              Image(
                width: 180,
                height: 180,
                image: AssetImage(images[7 - lives]),
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.red.shade900, width: 3)),
                child: Text(
                  _handleText(),
                  style: gothicTextStyle(45, Colors.grey[200]),
                ),
              ),

              //keyboard
              GridView.count(
                padding: EdgeInsets.only(left: 15),
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: letters.map((alphabet) {
                  return InkWell(
                    onTap: guessedLetters.contains(alphabet)
                        ? null
                        : () => _checkLetter(alphabet),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          alphabet,
                          style: gothicTextStyle(
                              35,
                              guessedLetters.contains(alphabet)
                                  ? Colors.red.shade900
                                  : Colors.white),
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
