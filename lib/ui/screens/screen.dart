import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hix/blocs/bloc.dart';
import 'package:hix/models/model.dart';
import 'package:hix/services/service.dart';
import 'package:hix/shared/shared.dart';
import 'package:hix/ui/widgets/widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';

part 'wrapper.dart';

part 'authentication/sign_in_page.dart';

part 'authentication/sign_up_page.dart';

part 'authentication/sign_up_preference_page.dart';

part 'authentication/confirmation_page.dart';

part 'authentication/splash_screen.dart';

part 'home/home_page.dart';

part 'home/movie_page.dart';
