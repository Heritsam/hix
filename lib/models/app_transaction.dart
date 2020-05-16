part of 'model.dart';

class AppTransaction extends Equatable {
  final String userId;
  final String title;
  final String subtitle;
  final int total;
  final DateTime time;
  final String picture;

  AppTransaction({
    @required this.userId,
    @required this.title,
    @required this.subtitle,
    this.total = 0,
    @required this.time,
    this.picture,
  });

  @override
  List<Object> get props => [userId, title, subtitle, total, time, picture];
}
