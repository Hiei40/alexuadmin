class Announcement {
  String name;
  String news;
  String photo;

  Announcement({
    required this.name,
    required this.news,
    required this.photo,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      name: json['Name'],
      news: json['News'],
      photo: json['Photo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['News'] = this.news;
    data['Photo'] = this.photo;
    return data;
  }
}
