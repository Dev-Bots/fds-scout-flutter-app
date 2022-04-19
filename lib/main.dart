import 'dart:convert';
import 'package:fds_scout_flutter_app/Bloc/AccountBloc/account_bloc.dart';
import 'package:fds_scout_flutter_app/Data/provider/account/AccountProvider.dart';
import 'package:fds_scout_flutter_app/Presentation/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:logs/logs.dart';
import 'package:fds_scout_flutter_app/Data/repository/repository.dart';
import 'bloc_observer.dart';

WidgetsBinding ensureInitialized() {
  if (WidgetsBinding.instance == null) WidgetsFlutterBinding();
  return WidgetsBinding.instance;
}

// final Log httpLog = Log('http');
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() => {
      // httpLog.enabled = true,
      // ensureInitialized(),
      BlocOverrides.runZoned(
        () {},
        blocObserver: SimpleBlocObserver(),
      ),
      WidgetsFlutterBinding.ensureInitialized(),
      runApp(PlayerApp()),
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    };

class PlayerApp extends StatelessWidget {
  PlayerApp({Key? key}) : super(key: key);

//  There is BlocProvider here because the AccountBloc is needed globally
  final repo = AccountRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: repo,
        child: BlocProvider(
            create: (context) => AccountBloc()..add(GetMyAccount()),
            child: MaterialApp(
              supportedLocales: const [
                Locale('de'),
                Locale('en'),
                Locale('es'),
                Locale('fr'),
                Locale('am'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                FormBuilderLocalizations.delegate,
              ],
              title: 'Player Application',
              theme: ThemeData(
                textTheme: GoogleFonts.ubuntuTextTheme(
                  Theme.of(context).textTheme,
                ),
                // primarySwatch: const Color(0xFF343A40),
                primaryColor: Colors.black,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: RouteGenerator
                  .splashPage, // This needs to be changed to the front page/ or the splash screen when we make one
              onGenerateRoute: RouteGenerator.generateRoute,
              navigatorKey: navigatorKey,
            )));
  }
}
