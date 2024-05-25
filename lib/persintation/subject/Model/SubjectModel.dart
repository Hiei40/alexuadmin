class Course {
  String doctorEmail;
  String level;
  String name;

  Course({
    required this.doctorEmail,
    required this.level,
    required this.name,
  });

  // Factory constructor to create a Course instance from a JSON map
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      doctorEmail: json['DoctorEmail'] as String,
      level: json['Level'] as String,
      name: json['Name'] as String,
    );
  }

  // Method to convert a Course instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'DoctorEmail': doctorEmail,
      'Level': level,
      'Name': name,
    };
  }
}