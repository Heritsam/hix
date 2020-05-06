import 'package:equatable/equatable.dart';
import 'package:hix/models/model.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashScreenPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignInPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToHomePage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignUpPage extends PageEvent {
  final RegistrationData registrationData;

  GoToSignUpPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class GoToSignUpPreferencePage extends PageEvent {
  final RegistrationData registrationData;

  GoToSignUpPreferencePage(this.registrationData);

  @override
  List<Object> get props => [];
}

class GoToSignUpConfirmationPage extends PageEvent {
  final RegistrationData registrationData;

  GoToSignUpConfirmationPage(this.registrationData);

  @override
  List<Object> get props => [];
}
