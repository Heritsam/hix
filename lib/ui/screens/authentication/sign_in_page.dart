part of '../screen.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isLoading = false;

  void _signInButtonPressed() async {
    setState(() {
      _isLoading = true;
    });

    AuthServiceResult result = await AuthService.signIn(
      _emailController.text,
      _passwordController.text,
    );

    if (result.user == null) {
      setState(() => _isLoading = false);
      Toast.show(
        result.message,
        context,
        backgroundColor: Colors.redAccent,
        duration: Toast.LENGTH_LONG,
      );
    } else {
      setState(() => _isLoading = false);
      print(result.user);
    }
  }

  void _navigateToSignUpPage() {
    BlocProvider.of<PageBloc>(context).add(GoToSignUpPage(RegistrationData()));
  }

  void _navigateToSplashScreen() {
    BlocProvider.of<PageBloc>(context).add(GoToSplashScreenPage());
  }

  void _navigateToForgotPassword() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ForgotPasswordPage(email: _emailController.text),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<PageBloc>(context).add(GoToSplashScreenPage());

        return;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: IconButton(
              onPressed: _navigateToSplashScreen,
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    'Welcome Back,\nCinephilia!',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  SizedBox(height: 32.0),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isEmailValid = EmailValidator.validate(value);
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _isPasswordValid = value.length >= 4;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: _navigateToForgotPassword,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Center(
                    child: Column(
                      children: <Widget>[
                        _isLoading
                            ? CircularProgressIndicator()
                            : Container(
                                width: 200.0,
                                child: RaisedButton(
                                  onPressed: _isEmailValid && _isPasswordValid
                                      ? _signInButtonPressed
                                      : null,
                                  child: Text(
                                    'Sign in',
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                  ),
                                  elevation: 0.0,
                                ),
                              ),
                        FlatButton(
                          onPressed: _navigateToSignUpPage,
                          child: Text(
                            'I don\'t have an account',
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
                  SizedBox(height: 64.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
