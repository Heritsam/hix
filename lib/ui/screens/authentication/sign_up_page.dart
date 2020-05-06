part of '../screen.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  const SignUpPage(this.registrationData);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _navigateBack() {
    BlocProvider.of<PageBloc>(context).add(GoToSplashScreenPage());
  }

  void _addPicture() async {
    widget.registrationData.profilePicture = await getImage();
    setState(() {});
  }

  void _removePicture() {
    CupertinoAlertDialog alertDialog = CupertinoAlertDialog(
      title: Text('Remove Image'),
      content: Text('Are you sure you want to remove this image?'),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
            widget.registrationData.profilePicture = null;
            setState(() {});
          },
          child: Text('Yes'),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alertDialog);
  }

  void _nextButtonPressed() {
    if (_formKey.currentState.validate()) {
      widget.registrationData.name = _nameController.text;
      widget.registrationData.email = _emailController.text;
      widget.registrationData.password = _passwordController.text;

      BlocProvider.of<PageBloc>(context).add(
        GoToSignUpPreferencePage(widget.registrationData),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.registrationData.name;
    _emailController.text = widget.registrationData.email;
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
          title: Text('Create your account'),
          leading: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: IconButton(
              onPressed: _navigateBack,
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  _buildPictureUpload(),
                  SizedBox(height: 32.0),
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.label_outline),
                    ),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Error: Required';
                      }

                      if (value.trim().length < 4) {
                        return 'Error: At least 4 characters';
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: 'Email Address',
                      prefixIcon: Icon(Icons.alternate_email),
                    ),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Error: Required';
                      }

                      if (!EmailValidator.validate(value)) {
                        return 'Error: Incorrect format';
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Error: Required';
                      }

                      if (value.trim().length < 6) {
                        return 'Error: At least 6 characters';
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    // ignore: missing_return
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Error: Required';
                      }

                      if (value != _passwordController.text) {
                        return 'Error: Password didn\'t match';
                      }
                    },
                  ),
                  SizedBox(height: 32.0),
                  FloatingActionButton.extended(
                    onPressed: _nextButtonPressed,
                    label: Text('Next'),
                    icon: Icon(Icons.chevron_right),
                    elevation: 0.0,
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

  Widget _buildPictureUpload() {
    return Container(
      height: 106,
      width: 90,
      child: Stack(
        children: <Widget>[
          Container(
            height: 90,
            width: 90,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: widget.registrationData.profilePicture == null
                  ? _addPicture
                  : _removePicture,
              child: Container(
                height: 32.0,
                width: 32.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColorLight,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                child: widget.registrationData.profilePicture == null
                    ? Icon(Icons.add, color: Colors.white)
                    : Icon(Icons.delete, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
