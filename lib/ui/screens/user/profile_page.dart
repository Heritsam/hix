part of '../screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _signOutButtonPressed() {
    CupertinoAlertDialog alertDialog = CupertinoAlertDialog(
      title: Text('Confirm Log Out'),
      content: Text('Are you sure you want to log out?'),
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
            Navigator.pop(context);
            AuthService.signOut();
          },
          isDestructiveAction: true,
          child: Text('Yes'),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alertDialog);
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationIcon: Image.asset('assets/logo.png', width: 38.0),
      applicationVersion: '1.0.0',
      applicationLegalese:
          'HIX is a movie ticket buying application built using Flutter and Firebase',
      children: <Widget>[
        SizedBox(height: 32.0),
        Text('Movie Category icons made by Freepik'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                _ProfileHeader(),
                _buildPageContent(),
              ],
            ),
          ),
          FloatingBackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    Size size = MediaQuery.of(context).size;
    double paddingTop = MediaQuery.of(context).padding.top;

    List<BoxShadow> _boxShadows = [
      BoxShadow(
        blurRadius: 24.0,
        color: Colors.black.withOpacity(0.22),
        offset: Offset(0, 16.0),
      ),
      BoxShadow(
        blurRadius: 6.0,
        color: Colors.black.withOpacity(0.14),
        offset: Offset(0, 2.0),
      ),
      BoxShadow(
        blurRadius: 1.0,
        color: Colors.black.withOpacity(0.08),
        offset: Offset(0, 0),
      ),
    ];

    return Column(
      children: <Widget>[
        _buildContentHeader(),
        Container(
          height: size.height - (size.height * .35 - paddingTop),
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.blueGrey[50],
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            boxShadow: _boxShadows,
          ),
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                  User user = (state as UserLoadSuccess).user;

                  return ListTile(
                    onTap: user != null
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfilePage(user: user),
                                ));
                          }
                        : null,
                    title: Text('Edit Profile'),
                    leading: Icon(Icons.edit),
                  );
                }),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WalletPage(),
                        ));
                  },
                  title: Text('My Wallet'),
                  leading: Icon(Icons.account_balance_wallet),
                ),
                Divider(),
                ListTile(
                  onTap: _showAboutDialog,
                  title: Text('About'),
                  leading: Icon(Icons.info),
                ),
                SizedBox(height: 32.0),
                Container(
                  width: size.width,
                  child: OutlineButton(
                    onPressed: _signOutButtonPressed,
                    child: Text('Sign Out'),
                    textColor: primaryColor,
                    highlightedBorderColor: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentHeader() {
    Size size = MediaQuery.of(context).size;
    double paddingTop = MediaQuery.of(context).padding.top;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadSuccess) {
          return Container(
            height: size.height * .35 - paddingTop,
            child: Padding(
              padding: EdgeInsets.only(top: paddingTop),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white38,
                          width: 2.0,
                        ),
                      ),
                      child: Stack(
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: shimmerBaseColor,
                            highlightColor: shimmerHighlightColor,
                            child: Container(
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            height: 80.0,
                            width: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: state.user.profilePicture == ''
                                    ? AssetImage(
                                        'assets/profile_picture.png',
                                      )
                                    : NetworkImage(
                                        state.user.profilePicture,
                                      ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      state.user.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      state.user.email,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .35,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColorLight,
            primaryColor,
          ],
        ),
      ),
    );
  }
}
