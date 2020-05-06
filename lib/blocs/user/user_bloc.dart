import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hix/models/model.dart';
import 'package:hix/services/service.dart';
import '../bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      User user = await UserService.getUser(event.id);

      yield UserLoadSuccess(user);
    } else if (event is UserSignedOut) {
      yield UserInitial();
    }
  }
}
