import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hix/services/service.dart';
import 'package:hix/shared/shared.dart';
import 'package:hix/ui/screens/screen.dart';
import 'package:provider/provider.dart';

import 'blocs/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService.userStream,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PageBloc(),
          ),
          BlocProvider(
            create: (context) => UserBloc(),
          ),
          BlocProvider(
            create: (context) => MovieBloc()..add(FetchMovie()),
          ),
          BlocProvider(
            create: (context) => TicketBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HIX',
          theme: ThemeData(
            primaryColor: primaryColor,
            accentColor: primaryColor,
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
              buttonColor: primaryColor,
            ),
            appBarTheme: AppBarTheme(
              elevation: 0.0,
              color: Colors.transparent,
              textTheme: TextTheme(
                headline6: GoogleFonts.nunitoSans(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.black54),
            ),
            textTheme: GoogleFonts.nunitoSansTextTheme(),
          ),
          home: Wrapper(),
        ),
      ),
    );
  }
}
