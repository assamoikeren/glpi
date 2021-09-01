import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import './screens/auth_screen.dart';
import './screens/dashboard_screen.dart';
import './screens/work_order_screen.dart';
import './screens/incidents_screen.dart';
import './screens/ticket_details_screen.dart';
import './screens/signature.dart';
import './screens/checklist.dart';
import './screens/close_ticket.dart';
import './screens/checklist_pictures.dart';
import './screens/photos.dart';
import './screens/workorders_procedures.dart';
import './providers/tickets_provider.dart';
import './models/ticket.dart';
import './models/task.dart';
import './providers/auth.dart';
import './providers/ticket_suivi_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './database/moor_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool connected1 = prefs.getBool('connected');
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(),
      child: MyApp(connected: connected1),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool connected;
  MyApp({@required this.connected});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Tickets(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Ticket(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Task(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TicketSuivi(),
        ),
        Provider(
          create: (_) => AppDatabase().localTicketDao,
        ),
      ],
      child: MaterialApp(
        title: 'GLPI mobile',
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('fr', ''), // English, no country code
          Locale('en', ''), // french, no country code
        ],
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 113, 187, 1),
          fontFamily: 'Quicksand',
          accentColor: Color.fromRGBO(57, 162, 209, 1),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  // ignore: deprecated_member_use
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
          ),
        ),
        home: new Scaffold(
          body: Center(
              child: widget.connected == false || widget.connected == null
                  ? AuthScreen()
                  : DashboardScreen()),
        ),
        routes: {
          AuthScreen.routeName: (context) => AuthScreen(),
          DashboardScreen.routeName: (context) => DashboardScreen(),
          WorkOrderScreen.routeName: (context) => WorkOrderScreen(),
          IncidentScreen.routeName: (context) => IncidentScreen(),
          TicketDetailsScreen.routeName: (context) => TicketDetailsScreen(),
          CloseTicket.routeName: (context) => CloseTicket(),
          TicketSignature.routeName: (context) => TicketSignature(),
          Procedure.routeName: (context) => Procedure(),
          Checklist.routeName: (context) => Checklist(),
          Photos.routeName: (context) => Photos(),
          CheckPhotos.routeName: (context) => CheckPhotos(),
        },
      ),
    );
  }
}
