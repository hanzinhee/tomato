class Schedule {
  final int id;
  final String from;
  final String to;
  final String time;

  Schedule({this.id, this.from, this.to, this.time});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      from: json['from'],
      to: json['to'],
      time: json['time'],
    );
  }
}
