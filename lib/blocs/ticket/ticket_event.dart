import 'package:equatable/equatable.dart';
import 'package:hix/models/model.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();
}

class LoadTicket extends TicketEvent {
  final String userId;

  LoadTicket(this.userId);

  @override
  List<Object> get props => [userId];
}

class BuyTicket extends TicketEvent {
  final Ticket ticket;
  final String userId;

  BuyTicket(this.ticket, this.userId);

  @override
  List<Object> get props => [ticket, userId];
}
