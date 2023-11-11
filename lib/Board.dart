class Board {
  final int size;
  var coord;

  Board(this.size, this.coord);

  ///Board is initialized with a list that creates an 'Empty' board.
  static Board generateBoard(size) {
    var coord = List.generate(
        size, (i) => List.filled(size, '.', growable: false),
        growable: false);
    return Board(size, coord);
  }

  ///Updates the board with the user move.
  void updateBoardUser(move) {
    var x = move['x'];
    var y = move['y'];
    if (coord[y][x] == '.') {
      coord[y][x] = 'O';
    }
  }

  ///Updates the board with the server move.
  void updateBoardComp(move) {
    var x = move['x'];
    var y = move['y'];
    print('Server: ${x + 1} ${y + 1}');
    if (coord[y][x] == '.') {
      coord[y][x] = 'X';
    }
  }

  ///Hilights winning line
  void winningLine(var ackMove, var move) {
    List<dynamic> row;
    if (ackMove['isWin']) {
      row = ackMove['row'];
      for (var i = 1; i < row.length; i = i + 2) {
        coord[row[i]][row[i - 1]] = 'W';
      }
    } else if (move['isWin']) {
      row = move['row'];
      for (var i = 1; i < row.length; i = i + 2) {
        coord[row[i]][row[i - 1]] = 'L';
      }
    }
  }
}
