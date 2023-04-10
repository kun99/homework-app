class Course{

  int? id;
  String course;
  Course({this.id, required this.course});

  factory Course.fromMap(Map<String, dynamic> json) => Course(
    id: json['id'],
    course: json['course'],
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'course': course,
    };
  }
}