class Info {
  var size;
  var strategies;

  ///Class specific json parser.
  Info.fromJson(Map<String, dynamic> json)
      : size = json['size'],
        strategies = json['strategies'];
}
