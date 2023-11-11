class Play {
  var response;
  var ack_move;
  var move;

  ///Class specific json parser.
  Play.fromJson(Map<String, dynamic> json)
      : response = json['response'],
        ack_move = json['ack_move'],
        move = json['move'];
}
