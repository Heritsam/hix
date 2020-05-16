import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hix/models/model.dart';
import 'package:hix/services/service.dart';
import '../bloc.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  @override
  TicketState get initialState => TicketState([]);

  @override
  Stream<TicketState> mapEventToState(
    TicketEvent event,
  ) async* {
    if (event is BuyTicket) {
      await TicketService.saveTicket(event.userId, event.ticket);

      List<Ticket> tickets = state.tickets + [event.ticket];

      yield TicketState(tickets);
    } else if (event is BuyTicket) {
      List<Ticket> tickets = await TicketService.getTickets(event.userId);

      yield TicketState(tickets);
    }
  }
}
