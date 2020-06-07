import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:hix/blocs/bloc.dart';
import 'package:hix/models/model.dart';
import 'package:hix/services/service.dart';
import 'package:hix/shared/shared.dart';
import 'package:hix/ui/widgets/widget.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({Key key, @required this.user}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController;
  String _profilePath;
  bool _isDataEdited = false;
  File _profileImageFile;
  bool _isUpdating = false;

  void _resetPassword(BuildContext context) async {
    await AuthService.resetPassword(widget.user.email);

    Toast.show(
      'Check your email to reset your password',
      context,
      duration: Toast.LENGTH_LONG,
    );
  }

  void _uploadProfilePicture(BuildContext context) async {
    if (_profilePath == '') {
      _profileImageFile = await getImage();

      if (_profileImageFile != null) {
        _profilePath = basename(_profileImageFile.path);
      }
    } else {
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
              _profileImageFile = null;
              _profilePath = '';
            },
            isDestructiveAction: true,
            child: Text('Yes'),
          ),
        ],
      );

      showDialog(context: context, builder: (context) => alertDialog);
    }

    setState(
      () {
        _isDataEdited = (_nameController.text.trim() != widget.user.name ||
                _profilePath != widget.user.profilePicture)
            ? true
            : false;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.user.name);
    _profilePath = widget.user.profilePicture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: <Widget>[
            _buildProfilePicture(context),
            SizedBox(height: 32.0),
            AbsorbPointer(
              child: TextField(
                controller: TextEditingController(text: widget.user.userId),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: "User ID",
                  prefixIcon: Icon(Icons.info_outline),
                ),
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(height: 16.0),
            AbsorbPointer(
              child: TextField(
                controller: TextEditingController(text: widget.user.email),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: "Email Address",
                  prefixIcon: Icon(Icons.alternate_email),
                ),
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _isDataEdited = true;
                });
              },
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.label_outline),
              ),
            ),
            SizedBox(height: 32.0),
            GradientFab(
              onPressed: _isDataEdited || _isUpdating
                  ? () async {
                      setState(() {
                        _isUpdating = true;
                      });

                      if (_profileImageFile != null) {
                        _profilePath = await uploadImage(_profileImageFile);
                      }

                      BlocProvider.of<UserBloc>(context).add(
                        UserUpdate(
                          name: _nameController.text,
                          profileImage: _profilePath,
                        ),
                      );

                      Navigator.pop(context);
                    }
                  : null,
              label: Text('Update profile'),
              icon: Icon(Icons.update),
            ),
            SizedBox(height: 8.0),
            FlatButton(
              onPressed: () {
                _resetPassword(context);
              },
              child: Text('Reset password'),
              textColor: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 32.0),
            _isUpdating
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(),
            SizedBox(height: 64.0),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture(BuildContext context) {
    return Container(
      width: 90,
      height: 106,
      child: Stack(
        children: <Widget>[
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: (_profileImageFile != null)
                    ? FileImage(_profileImageFile)
                    : (_profilePath != "")
                        ? NetworkImage(_profilePath)
                        : AssetImage("assets/profile_picture.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () => _uploadProfilePicture(context),
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
                child: _profilePath == ''
                    ? Icon(Icons.add, color: Colors.white)
                    : Icon(Icons.delete, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
