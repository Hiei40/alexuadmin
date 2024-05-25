class Progress {
  final int finalGrade;
  final int medtermGrad;
  final String studentEmail;
  final String subject;
  final int yearWork;

  // Constructor
  Progress({
    required this.finalGrade,
    required this.medtermGrad,
    required this.studentEmail,
    required this.subject,
    required this.yearWork,
  });

  // Named constructor to create Student object from JSON
  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      finalGrade: json['Final'] as int,
      medtermGrad: json['MedtermGrad'] as int,
      studentEmail: json['StudentEmail'] as String,
      subject: json['Subject'] as String,
      yearWork: json['YearWork'] as int,
    );
  }
}