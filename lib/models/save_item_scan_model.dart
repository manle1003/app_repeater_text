class QRCode {
  String id;
  String qrCode;
  String title;
  bool favorite;
  bool? isPress;
  String type;
  DateTime dateTime;

  QRCode({
    required this.id,
    required this.qrCode,
    required this.title,
    required this.favorite,
    this.isPress,
    required this.type,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'qrCode': qrCode,
        'title': title,
        'favorite': favorite,
        'isPress': isPress,
        'type': type,
        'dateTime': dateTime.toIso8601String(),
      };

  factory QRCode.fromJson(Map<String, dynamic> json) {
    return QRCode(
      id: json['id'],
      qrCode: json['qrCode'],
      title: json['title'],
      favorite: json['favorite'],
      isPress: json['isPress'],
      type: json['type'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
