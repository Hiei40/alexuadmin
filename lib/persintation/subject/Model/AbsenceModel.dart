import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Absence {
  Timestamp dateOfAbsence;
  String email;
  String subject;
  String status;

  Absence({
    required this.dateOfAbsence,
    required this.email,
    required this.subject,
    required this.status,
  });

  // Factory constructor to create an Absence from JSON
  factory Absence.fromJson(Map<String, dynamic> json) {
    // Log the incoming JSON data for debugging
    print("Parsing JSON: $json");
    return Absence(
      dateOfAbsence: json['DateOFAbscence'] is Timestamp
          ? json['DateOFAbscence']
          : Timestamp.fromDate(parseCustomDate(json['DateOFAbscence'] ?? '')),
      email: json['Email'] ?? '',
      subject: json['Subject'] ?? '',
      status: json['Status'] ?? '',
    );
  }

  // Method to convert Absence to JSON
  Map<String, dynamic> toJson() {
    return {
      'DateOFAbscence': dateOfAbsence,
      'Email': email,
      'Subject': subject,
      'Status': status,
    };
  }

  // Function to parse custom date format
  static DateTime parseCustomDate(String dateString) {
    if (dateString.isEmpty) {
      return DateTime.now();
    }
    try {
      final dateFormat = DateFormat("yyyy-MM-dd");
      return dateFormat.parse(dateString).toUtc();
    } catch (e) {
      print("Error parsing date: $dateString. Error: $e");
      return DateTime.now();
    }
  }
}
