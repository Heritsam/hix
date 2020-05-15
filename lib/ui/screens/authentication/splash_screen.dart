part of '../screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _getStartedButtonPressed() {
    BlocProvider.of<PageBloc>(context).add(GoToSignUpPage(RegistrationData()));
  }

  void _navigateToSignInPage() {
    BlocProvider.of<PageBloc>(context).add(GoToSignInPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(64.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 48.0, bottom: 16.0),
                child: Text(
                  'New Experience',
                  style: Theme.of(context).textTheme.title.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 48.0),
                child: Text(
                  'Booking tickets and watching movies are now easier than before!',
                  textAlign: TextAlign.center,
                ),
              ),
              RaisedButton(
                onPressed: _getStartedButtonPressed,
                child: Text(
                  'Get started',
                  style: Theme.of(context).textTheme.button.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                ),
                elevation: 0.0,
              ),
              FlatButton(
                onPressed: _navigateToSignInPage,
                child: Text(
                  'I already have an account',
                  style: Theme.of(context).textTheme.button.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                textColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
