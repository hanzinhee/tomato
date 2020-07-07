class ToTerminal {
  final int id;
  final String name;

  ToTerminal({this.id, this.name});

  factory ToTerminal.fromJson(Map<String, dynamic> json) {
    return ToTerminal(
      id: json['id'],
      name: json['name'],
    );
  }
}
