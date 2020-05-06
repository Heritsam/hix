part of '../screen.dart';

class ConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  ConfirmationPage(this.registrationData);

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  bool _isLoading = false;

  void _navigateBack() {
    BlocProvider.of<PageBloc>(context).add(
      GoToSignUpPreferencePage(widget.registrationData),
    );
  }

  void _createAccountButtonPressed() async {
    setState(() {
      _isLoading = true;
    });

    imageFileToUpload = widget.registrationData.profilePicture;

    await AuthService.signUp(
      name: widget.registrationData.name,
      email: widget.registrationData.email,
      password: widget.registrationData.password,
      selectedGenres: widget.registrationData.selectedGenres,
      selectedLanguage: widget.registrationData.selectedLanguage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navigateBack();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Confirm Your Account'),
          leading: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: IconButton(
              onPressed: _navigateBack,
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
                vertical: 16.0,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: widget.registrationData.profilePicture == null
                            ? AssetImage('assets/profile_picture.png')
                            : FileImage(widget.registrationData.profilePicture),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Welcome,',
                    style: GoogleFonts.nunitoSans(
                      color: primaryColor,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    widget.registrationData.name,
                    style: GoogleFonts.nunitoSans(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 64.0),
                  Center(
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            onPressed: _createAccountButtonPressed,
                            child: Text('Yes, create my account'),
                            elevation: 0.0,
                            color: accentColor,
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
