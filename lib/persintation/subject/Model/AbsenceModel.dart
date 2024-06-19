class Absence {
  String dateOfAbsence;
  String email;
  String status;
  String subject;

  Absence({
    required this.dateOfAbsence,
    required this.email,
    required this.status,
    required this.subject,
  });

  // Factory constructor to create an instance from JSON
  factory Absence.fromJson(Map<String, dynamic> json) {
    return Absence(
      dateOfAbsence: json['DateOFAbscence'],
      email: json['Email'],
      status: json['Status'],
      subject: json['Subject'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'DateOFAbscence': dateOfAbsence,
      'Email': email,
      'Status': status,
      'Subject': subject,
    };
  }
}
