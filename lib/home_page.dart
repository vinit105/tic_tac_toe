import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String playerX = "x";
  static const String playerO = "o";
  String currentPlayer = playerX;
  late bool gameEnd;
  late List<String> occupied;
  int scoreX = 0;
  int scoreO = 0;
  @override
  void initState() {
    initialGame();
    super.initState();
  }

  void initialGame() {
    gameEnd = false;
    occupied = [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _headerText(),
            _gameContainer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _clearButton(),
                const SizedBox(
                  width: 60,
                ),
                _resetButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return Column(
      children: [
        const Text(
          "Tic Tac Toe",
          style: TextStyle(color: Colors.white, fontSize: 32),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
               height: 75,
                //height: MediaQuery.of(context).size.height/10,
                width: 150,
                decoration: BoxDecoration(
                  color: currentPlayer == playerX
                      ? Colors.blueAccent
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text("PLAYER X \n      $scoreX",
                      style: const TextStyle(color: Colors.white, fontSize: 22)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 75,
                width: 150,
                decoration: BoxDecoration(
                  color: currentPlayer == playerO
                      ? Colors.pinkAccent
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text("PLAYER O \n      $scoreO",
                      style: const TextStyle(color: Colors.white, fontSize: 22)),
                ),
              ),
            ),
          ],
        ),

        // Text("Turn $currentPlayer",
        //     style: const TextStyle(color: Colors.white, fontSize: 32)),
      ],
    );
  }

  Widget _clearButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            initialGame();
          });
        },
        child: const Text(
          "CLEAR",
          style: TextStyle(fontSize: 15),
        ));
  }

  Widget _resetButton() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            currentPlayer = playerX;
            scoreX = scoreO = 0;
            initialGame();
          });
        },
        child: const Text(
          "RESET",
          style: TextStyle(fontSize: 15),
        ));
  }

  Widget _gameContainer() {
    return Container(
      //color: Colors.yellow,
      //color: Colors.yellow,
      height: MediaQuery.of(context).size.height *0.6,
      width: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, int index) {
          return _box(index);
        },
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget _box(int index) {
    return InkWell(
      onTap: () {
        if (gameEnd || occupied[index].isNotEmpty) {
          return;
        }
        setState(() {
          occupied[index] = currentPlayer;
          changeTurn();
          checkWinner();
          checkDraw();
        });
      },
      child: Container(
          color: occupied[index].isEmpty
              ? Colors.black26
              : occupied[index] == playerX
                  ? Colors.blueAccent
                  : Colors.pinkAccent,
          margin: const EdgeInsets.all(8),
          child: Center(
              child: Text(
            occupied[index],
            style: const TextStyle(fontSize: 45, color: Colors.white),
          ))),
    );
  }

  void changeTurn() {
    if (currentPlayer == playerX) {
      currentPlayer = playerO;
    } else {
      currentPlayer = playerX;
    }
  }

  void checkWinner() {
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var winningPos in winningList) {
      String playerPosition0 = occupied[winningPos[0]];
      String playerPosition1 = occupied[winningPos[1]];
      String playerPosition2 = occupied[winningPos[2]];

      if (playerPosition0.isNotEmpty) {
        if (playerPosition0 == playerPosition1 &&
            playerPosition0 == playerPosition2) {
          showGamerOver("Player $playerPosition0 Won");
          if (playerPosition0 == "x") {
            scoreX++;
            currentPlayer = playerX;
            setState(() {});
          }
          if (playerPosition0 == "o") {
            scoreO++;
            currentPlayer = playerO;
            setState(() {});
          }
          gameEnd = true;
          return;
        }
      }
    }
  }

  void checkDraw() {
    if (gameEnd) {
      return;
    }
    bool draw = true;
    for (var occupiedPlayer in occupied) {
      if (occupiedPlayer.isEmpty) {
        draw = false;
      }
    }
    if (draw) {
      changeTurn();
      showGamerOver("DRAW");
      gameEnd = true;
    }
  }

  void showGamerOver(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Game Over \n $message",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        backgroundColor: message == "DRAW"
            ? Colors.grey
            : message == "Player o Won" ? Colors.pinkAccent
                : Colors.blueAccent,
        duration: const Duration(milliseconds: 600),
      ),
    );
  }
}
