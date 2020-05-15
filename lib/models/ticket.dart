part of 'model.dart';

class Ticket extends Equatable {
  final MovieDetail movieDetail;
  final Theater theater;
  final DateTime time;
  final String bookingCode;
  final List<String> seats;
  final String name;
  final int totalPrice;

  Ticket({
    @required this.movieDetail,
    @required this.theater,
    @required this.time,
    @required this.bookingCode,
    @required this.seats,
    @required this.name,
    @required this.totalPrice,
  });

  Ticket copyWith({
    MovieDetail movieDetail,
    Theater theater,
    DateTime time,
    String bookingCode,
    List<String> seats,
    String name,
    int totalPrice,
  }) {
    return Ticket(
      movieDetail: movieDetail ?? this.movieDetail,
      theater: theater ?? this.theater,
      time: time ?? this.time,
      bookingCode: bookingCode ?? this.bookingCode,
      seats: seats ?? this.seats,
      name: name ?? this.name,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  String get seatsInString {
    String s = '';

    for (var seat in seats) {
      s += seat + ((seat != seats.last) ? ', ' : '');
    }

    return s;
  }

  @override
  List<Object> get props =>
      [movieDetail, theater, time, bookingCode, seats, name, totalPrice];
}
