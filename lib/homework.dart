class Homework{

  int? id;
  String title;
  String course;
  String date;
  Homework({this.id, required this.title, required this.course, required this.date});

  factory Homework.fromMap(Map<String, dynamic> json) => Homework(
    id: json['id'],
    title: json['title'],
    course: json['course'],
    date: json['date'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'source': course,
      'date': date,
    };
  }
}