import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeGame());
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  var cells = ['', '', '', '', '', '', '', '', '', ''];
  var turnO = true;
  var end = false;
  var result = '';
  var winner = '';
  var playerOWins = 0;
  var playerXWins = 0;
  var filledCells = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 50, 0, 82),
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 78, 21, 114),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  refresh();
                });
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              getScoreBoard(),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 30,
              ),
              getRefreshButton(end),
              SizedBox(
                height: 30,
              ),
              getCourt(context),
              SizedBox(
                height: 30,
              ),
              Text(
                turnO ? 'Turn O' : 'Turn X',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Player O : ' + playerOWins.toString(),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Text(
          'Player X : ' + playerXWins.toString(),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }

  Widget getCourt(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: 9,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onTapCell(index);
              },
              child: getCell(index),
            );
          },
        ),
      ),
    );
  }

  Widget getCell(int index) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: Center(
        child: Text(
          cells[index],
          style: TextStyle(
            color: (cells[index] == 'O'
                ? const Color.fromARGB(255, 39, 255, 46)
                : Colors.blue),
            fontSize: (25),
          ),
        ),
      ),
    );
  }

  void onTapCell(int index) {
    setState(() {
      if (end) return;

      if (cells[index].isNotEmpty) return;

      if (turnO) {
        cells[index] = 'O';
        turnO = !turnO;
        filledCells = filledCells + 1;
      } else {
        cells[index] = 'X';
        turnO = !turnO;
        filledCells = filledCells + 1;
      }

      checkWinnder();
    });
  }

  void checkWinnder() {
    if (cells[0] == cells[1] &&
        cells[0] == cells[2] &&
        cells[0] != '' &&
        !end) {
      result = 'Winner is ' + cells[0];
      winner = cells[0];
      end = true;
    } else if (cells[3] == cells[4] &&
        cells[3] == cells[5] &&
        cells[3] != '' &&
        !end) {
      result = 'Winner is ' + cells[3];
      winner = cells[3];
      end = true;
    } else if (cells[6] == cells[7] &&
        cells[6] == cells[8] &&
        cells[6] != '' &&
        !end) {
      result = 'Winner is ' + cells[6];
      winner = cells[6];
      end = true;
    } else if (cells[0] == cells[3] &&
        cells[0] == cells[6] &&
        cells[0] != '' &&
        !end) {
      result = 'Winner is ' + cells[0];
      end = true;
      winner = cells[0];
    } else if (cells[1] == cells[4] &&
        cells[1] == cells[7] &&
        cells[1] != '' &&
        !end) {
      result = 'Winner is ' + cells[1];
      winner = cells[1];
      end = true;
    } else if (cells[2] == cells[5] &&
        cells[2] == cells[8] &&
        cells[2] != '' &&
        !end) {
      result = 'Winner is ' + cells[2];
      winner = cells[2];
      end = true;
    } else if (cells[0] == cells[4] &&
        cells[0] == cells[8] &&
        cells[0] != '' &&
        !end) {
      result = 'Winner is ' + cells[0];
      winner = cells[0];
      end = true;
    } else if (cells[2] == cells[4] &&
        cells[2] == cells[6] &&
        cells[2] != '' &&
        !end) {
      result = 'Winner is ' + cells[2];
      winner = cells[2];
      end = true;
    }

    if (winner == 'X') {
      playerXWins = playerXWins + 1;
    } else if (winner == 'O') {
      playerOWins = playerOWins + 1;
    }

    if (winner == '' && filledCells == 9) {
      end = true;
      result = 'Draw ';
    }
  }

  Widget getRefreshButton(bool visible) {
    return Visibility(
      visible: visible,
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            end = false;
            cells = ['', '', '', '', '', '', '', '', ''];
            result = '';
            turnO = true;
            winner = '';
            filledCells = 0;
          });
        },
        child: Text(
          result + '!  try again',
        ),
        style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
      ),
    );
  }

  void refresh() {
    end = false;
    cells = ['', '', '', '', '', '', '', '', ''];
    result = '';
    turnO = true;
    winner = '';
    playerOWins = 0;
    playerXWins = 0;
    filledCells = 0;
  }
}
