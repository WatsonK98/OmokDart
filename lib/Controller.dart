import 'Board.dart';
import 'ConsoleUI.dart';
import 'WebClient.dart';

///Controls information and data flow.
class Controller {
  var ui;
  var net;
  var url;

  ///Initializes game state
  void start() async {
    ui = ConsoleUI();
    ui.printMsg("Welcome to Omok game!");
    //Requests server URL.
    url = ui.askServerUrl();
    net = WebClient(url);
    //Gets info page JSON.
    var info = await net.getInfo();
    //Asks user for strategy.
    var strat = ui.askStrategy(info);
    //Gets pid from JSON
    var pid = await net.getNew(strat);
    //Creates a board once a new game has been created.
    var board = Board.generateBoard(info.size);

    //While loop creates a running state
    while (true) {
      //Shows the current state of the board
      ConsoleUI().showBoard(board.coord);

      //Ask player for a move.
      var pmove = ui.askMove();

      //Check if player made a correct move with multiple chances.
      while (pmove == false) {
        ui.printMsg('Invalid Move!');
        pmove = ui.askMove();
      }
      //Check move against the server.
      var response = await net.getPlay(pid, pmove);

      //If server response is false then keep checking moves.
      while (response == false) {
        ui.printMsg('Invalid Move!');
        pmove = ui.askMove();
        while (pmove == false) {
          ui.printMsg('Invalid Move!');
          pmove = ui.askMove();
        }
        response = await net.getPlay(pid, pmove);
      }

      //Supplies the player move.
      var ackMove = response.ack_move;
      //Supplies the server move.
      var move = response.move;

      //Updates the board with the user's move.
      board.updateBoardUser(ackMove);
      //Checks if user move is win condition.
      if (ackMove['isWin']) {
        board.winningLine(ackMove, move);
        ConsoleUI().showBoard(board.coord);
        ui.printMsg("Winner!");
        return;
        //Checks if user move is draw condition.
      } else if (ackMove['isDraw']) {
        ConsoleUI().showBoard(board.coord);
        ui.printMsg("Draw!");
        return;
      }
      //Updates the board with the server's move.
      board.updateBoardComp(move);
      //Checks if server move is win condition.
      if (move['isWin']) {
        board.winningLine(ackMove, move);
        ConsoleUI().showBoard(board.coord);
        ui.printMsg("Loser!");
        return;
        //Checks if server move is draw condition.
      } else if (move['isDraw']) {
        ConsoleUI().showBoard(board.coord);
        ui.printMsg("Draw!");
        return;
      }
    }
  }
}
