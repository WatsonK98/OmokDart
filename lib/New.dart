class New {
  var response;
  var pid;

  ///Class specific json parser.
  New.fromJson(Map<String, dynamic> json)
      : response = json['response'],
        pid = json['pid'];
}
