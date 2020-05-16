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
    } else if (event is UserUpdate) {
      User updatedUser = (state as UserLoadSuccess)
          .user
          .copyWith(name: event.name, profilePicture: event.profileImage);

      await UserService.updateUser(updatedUser);

      yield UserLoadSuccess(updatedUser);
    } else if (event is UserTopUp) {
      if (state is UserLoadSuccess) {
        try {
          User updatedUser = (state as UserLoadSuccess).user.copyWith(
            balance: (state as UserLoadSuccess).user.balance + event.amount,
          );

          await UserService.updateUser(updatedUser);

          yield UserLoadSuccess(updatedUser);
        } catch(e) {
          print(e);
        }
      }
    } else if (event is UserPurchase) {
      if (state is UserLoadSuccess) {
        try {
          User updatedUser = (state as UserLoadSuccess).user.copyWith(
            balance: (state as UserLoadSuccess).user.balance - event.amount,
          );

          await UserService.updateUser(updatedUser);

          yield UserLoadSuccess(updatedUser);
        } catch(e) {
          print(e);
        }
      }
    }
  }
}
