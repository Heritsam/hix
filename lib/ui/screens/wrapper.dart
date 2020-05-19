part of 'screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null) {
      if (!(prevPageEvent is GoToSplashScreenPage)) {
        prevPageEvent = GoToSplashScreenPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToHomePage)) {
        prevPageEvent = GoToHomePage();
        context.bloc<PageBloc>().add(prevPageEvent);
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        context.bloc<TicketBloc>().add(LoadTicket(firebaseUser.uid));
      }
    }

    return BlocBuilder<PageBloc, PageState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is OnSplashScreenPage) {
          return SplashScreen();
        }

        if (state is OnSignInPage) {
          return SignInPage();
        }

        if (state is OnSignUpPage) {
          return SignUpPage(state.registrationData);
        }

        if (state is OnSignUpPreferencePage) {
          return SignUpPreferencePage(state.registrationData);
        }

        if (state is OnSignUpConfirmationPage) {
          return ConfirmationPage(state.registrationData);
        }

        if (state is OnHomePage) {
          return HomePage();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
