part of '../screen.dart';

class SignUpPreferencePage extends StatefulWidget {
  final List<String> genres = <String>[
    'Horror',
    'Music',
    'Action',
    'Drama',
    'War',
    'Crime',
  ];

  final List<String> languages = <String>[
    'Bahasa Indonesia',
    'English',
    'Japanese',
    'Korean',
  ];

  final RegistrationData registrationData;

  SignUpPreferencePage(this.registrationData);

  @override
  _SignUpPreferencePageState createState() => _SignUpPreferencePageState();
}

class _SignUpPreferencePageState extends State<SignUpPreferencePage> {
  List<String> _selectedGenres = <String>[];
  String _selectedLanguage = 'English';

  void _navigateBack() {
    BlocProvider.of<PageBloc>(context).add(
      GoToSignUpPage(widget.registrationData),
    );
  }

  void _selectGenre(String genre) {
    if (_selectedGenres.contains(genre)) {
      setState(() {
        _selectedGenres.remove(genre);
      });
    } else {
      if (_selectedGenres.length < 4) {
        setState(() {
          _selectedGenres.add(genre);
        });
      }
    }
  }

  void _nextButtonPressed() {
    if (_selectedGenres.length != 4) {
      Toast.show(
        'Please select four genres',
        context,
        backgroundColor: Colors.redAccent,
        duration: Toast.LENGTH_LONG,
      );
    } else {
      widget.registrationData.selectedGenres = _selectedGenres;
      widget.registrationData.selectedLanguage = _selectedLanguage;

      BlocProvider.of<PageBloc>(context).add(
        GoToSignUpConfirmationPage(widget.registrationData),
      );
    }
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
          leading: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: IconButton(
              onPressed: _navigateBack,
              icon: Icon(Icons.arrow_back),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Select Your\nInterests',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 16.0),
                Wrap(
                  spacing: 24.0,
                  runSpacing: 16.0,
                  children: _buildGenreList(context),
                ),
                SizedBox(height: 32.0),
                Text(
                  'Language that\nyou prefer',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 16.0),
                Wrap(
                  spacing: 24.0,
                  runSpacing: 16.0,
                  children: _buildLanguageList(context),
                ),
                SizedBox(height: 32.0),
                Center(
                  child: FloatingActionButton.extended(
                    onPressed: _nextButtonPressed,
                    label: Text('Next'),
                    icon: Icon(Icons.chevron_right),
                    elevation: 0.0,
                  ),
                ),
                SizedBox(height: 64.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildGenreList(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.genres.map((item) {
      return SelectableBox(
        label: item,
        width: width,
        isSelected: _selectedGenres.contains(item),
        onTap: () => _selectGenre(item),
      );
    }).toList();
  }

  List<Widget> _buildLanguageList(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.languages.map((item) {
      return SelectableBox(
        label: item,
        width: width,
        isSelected: _selectedLanguage == item,
        onTap: () {
          setState(() {
            _selectedLanguage = item;
          });
        },
      );
    }).toList();
  }
}
