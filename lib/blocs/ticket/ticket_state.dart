import 'package:equatable/equatable.dart';
import 'package:hix/models/model.dart';

class TicketState extends Equatable {
  final List<Ticket> tickets;

  const TicketState(this.tickets);

  @override
  List<Object> get props => [tickets];
}