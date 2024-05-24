import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../image/image.dart';

class MainList {
  static List classListSubjectInfo = [];

  static List nameListSubjectInfo(BuildContext context) => [
        S.of(context).Attendance,
        S.of(context).Feedback,
        S.of(context).TrackyourProgress,
        S.of(context).Survey,
      ];

  static List imageListSubjectInfo = [
    MainImage.attendance,
    MainImage.feedback,
    MainImage.your_Progress,
    MainImage.survey,
  ];
}
