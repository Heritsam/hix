import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUser extends UserEvent {
  final String id;

  LoadUser(this.id);

  @override
  List<Object> get props => null;
}

class UserSignedOut extends UserEvent {
  @override
  List<Object> get props => [];
}
