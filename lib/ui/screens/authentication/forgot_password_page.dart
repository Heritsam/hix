import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hix/services/service.dart';
import 'package:toast/toast.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String email;

  const ForgotPasswordPage({Key key, @required this.email}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _emailController;
  bool _isEmailValid = false;
  bool _isLoading = false;

  void _resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    await AuthService.resetPassword(_emailController.text);

    Toast.show(
      'Check your email to reset your password',
      context,
      duration: Toast.LENGTH_LONG,
    );

    setState(() {
      _isLoading = false;
    });

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController(text: widget.email);
    _isEmailValid = EmailValidator.validate(_emailController.text);
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sign In',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'Reset Password',
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
              SizedBox(height: 32.0),
              Center(
                child: Column(
                  children: <Widget>[
                    _isLoading
                        ? CircularProgressIndicator()
                        : Container(
                      width: 200.0,
                      child: RaisedButton(
                        onPressed: _isEmailValid
                            ? _resetPassword
                            : null,
                        child: Text(
                          'Reset password',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

