part of '../screen.dart';

class MoviePage extends StatelessWidget {
  void _signOutButtonPressed(BuildContext context) {
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
            AuthService.signOut();
          },
          child: Text('Yes'),
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildPageHeader(),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Container(
      height: 164.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor,
            primaryColor,
            primaryColorLight,
            accentColor,
          ],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: BlocBuilder<UserBloc, UserState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state is UserLoadSuccess) {
                  if (imageFileToUpload != null) {
                    uploadImage(imageFileToUpload).then((downloadUrl) {
                      imageFileToUpload = null;
                      BlocProvider.of<UserBloc>(context)
                          .add(UserUpdate(profileImage: downloadUrl));
                    });
                  }

                  return Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _signOutButtonPressed(context),
                        child: Container(
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
                                baseColor: Colors.grey[300].withOpacity(0.8),
                                highlightColor: Colors.white.withOpacity(0.8),
                                child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                              Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: state.user.profilePicture == ''
                                        ? AssetImage('assets/profile_picture.png')
                                        : NetworkImage(state.user.profilePicture),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width -
                                2 * defaultMargin -
                                78 -
                                16,
                            child: Text(
                              state.user.name,
                              style: GoogleFonts.nunitoSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            NumberFormat.currency(
                              locale: 'id_ID',
                              decimalDigits: 0,
                              symbol: 'IDR ',
                            ).format(state.user.balance),
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                if (state is UserInitial) {
                  return Row(
                    children: <Widget>[
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300].withOpacity(0.8),
                        highlightColor: Colors.white.withOpacity(0.8),
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300].withOpacity(0.8),
                            highlightColor: Colors.white.withOpacity(0.8),
                            child: Container(
                              height: 25.0,
                              width: 138.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300].withOpacity(0.8),
                            highlightColor: Colors.white.withOpacity(0.8),
                            child: Container(
                              height: 19.0,
                              width: 80.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
