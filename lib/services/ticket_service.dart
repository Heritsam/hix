part of 'service.dart';

class TicketService {
  static CollectionReference ticketCollection =
      Firestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.document().setData({
      'movieId': ticket.movieDetail.id ?? '',
      'userId': id ?? '',
      'theaterName': ticket.theater.name ?? 0,
      'time': ticket.time.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice,
    });
  }

  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.getDocuments();
    var documents = snapshot.documents
        .where((document) => document.data['userId'] == userId);

    List<Ticket> tickets = [];

    for (var document in documents) {
      MovieDetail movieDetail =
          await MovieService.getMovieDetail(document.data['movieId']);

      tickets.add(Ticket(
        movieDetail: movieDetail,
        theater: Theater(document.data['theaterName']),
        time: DateTime.fromMicrosecondsSinceEpoch(document.data['time']),
        bookingCode: document.data['bookingCode'],
        seats: document.data['seats'].toString().split(','),
        name: document.data['name'],
        totalPrice: document.data['totalPrice'],
      ));
    }

    return tickets;
  }
}
