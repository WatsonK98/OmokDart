import 'package:http/http.dart' as http;
import 'dart:io';
import 'ResponseParser.dart';

class WebClient {
  var serverUrl;

  WebClient(this.serverUrl);

  ///Asks the server for info.
  Future getInfo() async {
    stdout.write('Obtaining server information .....');
    stdout.flush();
    //Concatenates URL.
    var url = '$serverUrl/info';
    //Await response.
    var response = await http.get(Uri.parse(url));
    //Parse data.
    var parse = ResponseParser(response);
    var data = parse.parseInfo(response);
    //Return data.
    return Future.delayed(Duration(milliseconds: 50), () => data);
  }

  ///Asks the server for a pid.
  Future getNew(var strat) async {
    stdout.writeln('Creating a new game .....');
    stdout.flush();
    //Concatenates URL.
    var url = '$serverUrl/new/?strategy=$strat';
    //Await response.
    var response = await http.get(Uri.parse(url));
    //Parse data.
    var parse = ResponseParser(response);
    var data = parse.parseNew(response);
    //Return data.
    return Future.delayed(Duration(milliseconds: 50), () => data);
  }

  ///Pushes move to a server and waits for response.
  Future getPlay(dynamic pid, List<int> move) async {
    //Concatenates URL.
    var url = '$serverUrl/play/?pid=${pid.pid}&x=${move[0]}&y=${move[1]}';
    //Await response.
    var response = await http.get(Uri.parse(url));
    //Parse data.
    var parse = ResponseParser(response);
    //If move is invalid on server side then call for a new input.
    if (parse == false) {
      return false;
    }
    var data = parse.parsePlay(response);
    //Return data.
    return Future.delayed(Duration(milliseconds: 50), () => data);
  }
}
