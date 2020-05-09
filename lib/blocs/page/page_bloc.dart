import 'dart:async';
import 'package:bloc/bloc.dart';
import '../bloc.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  PageState get initialState => InitialPage();

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToSplashScreenPage) {
      yield OnSplashScreenPage();
    } else if (event is GoToHomePage) {
      yield OnHomePage();
    } else if (event is GoToSignInPage) {
      yield OnSignInPage();
    } else if (event is GoToSignUpPage) {
      yield OnSignUpPage(event.registrationData);
    } else if (event is GoToSignUpPreferencePage) {
      yield OnSignUpPreferencePage(event.registrationData);
    } else if (event is GoToSignUpConfirmationPage) {
      yield OnSignUpConfirmationPage(event.registrationData);
    } else if (event is GoToMovieDetailPage) {
      yield OnMovieDetailPage(event.movie);
    }
  }
}
