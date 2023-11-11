import 'dart:convert';
import 'Info.dart';
import 'New.dart';
import 'Play.dart';

class ResponseParser {
  var response;

  ResponseParser(this.response);

  ///Returns INFO as parsed with json.
  parseInfo(response) {
    var data = json.decode(response.body);
    return Info.fromJson(data);
  }

  ///Returns NEW as parsed with json.
  parseNew(response) {
    var data = json.decode(response.body);
    return New.fromJson(data);
  }

  ///Returns PLAY as parsed with json.
  parsePlay(response) {
    var data = json.decode(response.body);
    if (data['response'] == false) {
      return false;
    }
    return Play.fromJson(data);
  }
}
