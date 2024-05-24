class Subject {
  String image;
  String name;

  Subject({required this.image, required this.name});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      image: json['Image'],
      name: json['Name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Image'] = this.image;
    data['Name'] = this.name;
    return data;
  }
}
