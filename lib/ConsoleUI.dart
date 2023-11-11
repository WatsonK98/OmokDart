import 'dart:io';
import 'Board.dart';

class ConsoleUI {
  //Prines a UI message.
  void printMsg(String s) {
    print(s);
  }

  ///Asks user for a server URL.
  askServerUrl() {
    var defaultUrl = 'https://www.cs.utep.edu/cheon/cs3360/project/omok/';
    stdout.write('Enter server URL (default): $defaultUrl: ');
    var url = stdin.readLineSync();
    //If user server URL is empty then defaults.
    if (url == '') {
      url = defaultUrl;
    }
    return url;
  }

  ///Asks user for a strategy
  askStrategy(dynamic info) {
    stdout.write(
        '\nSelect the server  strategy: 1. ${info.strategies[0]}  2. ${info.strategies[1]}  [default: 1] ');
    var line = stdin.readLineSync();
    try {
      var selection = int.parse(line!);
      if (selection == 1) {
        return 'Smart';
      } else if (selection == 2) {
        return 'Random';
      } else {
        //If no input then smart defaults.
        return 'Smart';
      }
      //If format exception then default.
    } on FormatException {
      return 'Smart';
    }
  }

  ///Asks user for a move.
  askMove() {
    stdout.write('Enter x and y [e.g. 8 10]: ');
    var line = stdin.readLineSync()!.split(' ');
    try {
      var x = int.parse(line[0]);
      var y = int.parse(line[1]);
      //Checks if move is within bounds.
      if (x < 1 || y < 1 || x > 15 || y > 15) {
        throw FormatException();
      }
      return [x - 1, y - 1];
      //If exception then let system know to ask again.
    } on FormatException {
      return false;
    } on RangeError {
      return false;
    }
  }

  ///Shows board state.
  void showBoard(var coord) {
    //Fills the column header.
    var indexes =
        List<int>.generate(coord.length, (i) => (i + 1) % 10).join(' ');
    stdout.writeln(' x $indexes');
    //Filles the column divider header.
    stdout.write('y ');
    for (var i = 0; i < coord.length; i++) {
      stdout.write('--');
    }
    //Fill rows.
    stdout.writeln();
    for (var i = 0; i < coord.length; i++) {
      stdout.write('${(i + 1) % 10}| ');
      stdout.writeln(coord[i].join(' '));
    }
  }
}
