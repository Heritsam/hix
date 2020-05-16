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

class UserUpdate extends UserEvent {
  final String name;
  final String profileImage;

  UserUpdate({this.name, this.profileImage});

  @override
  List<Object> get props => [name, profileImage];
}

class UserTopUp extends UserEvent {
  final int amount;

  UserTopUp(this.amount);

  @override
  List<Object> get props => throw UnimplementedError();
}

class UserPurchase extends UserEvent {
  final int amount;

  UserPurchase(this.amount);

  @override
  List<Object> get props => throw UnimplementedError();
}
