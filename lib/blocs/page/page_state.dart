import 'package:equatable/equatable.dart';
import 'package:hix/models/model.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class InitialPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashScreenPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSignInPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnHomePage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSignUpPage extends PageState {
  final RegistrationData registrationData;

  OnSignUpPage(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class OnSignUpPreferencePage extends PageState {
  final RegistrationData registrationData;

  OnSignUpPreferencePage(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class OnSignUpConfirmationPage extends PageState {
  final RegistrationData registrationData;

  OnSignUpConfirmationPage(this.registrationData);

  @override
  List<Object> get props => [registrationData];
}

class OnMovieDetailPage extends PageState {
  final Movie movie;

  OnMovieDetailPage(this.movie);

  @override
  List<Object> get props => [movie];
}
