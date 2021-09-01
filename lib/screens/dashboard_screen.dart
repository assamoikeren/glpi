import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../icons/eva_icons_icons.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/dash_ticket_card.dart';
import '../widgets/side_menu.dart';
import '../providers/tickets_provider.dart';
import '../providers/auth.dart';
import '../screens/incidents_screen.dart';
import '../screens/work_order_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import '../database/moor_database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  String _name;
  int numberWorkorders;
  int greenIncidents;
  int yellowIncidents;
  int redIncidents;
  // String _identifiant;
  int receivedMessage = 0;

  void getPermissionStatus() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.camera
    ].request();
  }

  Future<void> getName() async {
    final name =
        await Provider.of<AuthProvider>(context, listen: false).getName();
    setState(() {
      _name = name;
    });
    getPermissionStatus();
  }

  Future<void> number() async {
    final dao = Provider.of<LocalTicketDao>(context);
    List<LocalTicket> list = await dao.getAllTickets();
    int num = list.where((t) => t.type == 2).length;
    int numGreen = list.where((t) => t.type == 1 && t.sla == 'green').length;
    int numRed = list.where((t) => t.type == 1 && t.sla == 'rouge').length;
    int numYellow = list.where((t) => t.type == 1 && t.sla == 'rouge').length;
    setState(() {
      numberWorkorders = num;
      greenIncidents = numGreen;
      yellowIncidents = numYellow;
      redIncidents = numRed;
    });
  }

  @override
  void initState() {
    //WidgetsBinding.instance.addObserver(this);
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      number();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        print('reveived');
        Provider.of<Tickets>(context, listen: false).fetchTickets(context);
      });
    });
  }

  /*  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  } */

  /* @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<Tickets>(context, listen: false).fetchTickets(context);
      });
    }
  } */

  @override
  Widget build(BuildContext context) {
    getName();

    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: false,
      elevation: 0,
      actions: [
        Image.asset(
          'assets/images/logo_2.png',
        ),
      ],
    );
    /*  final dao = Provider.of<LocalTicketDao>(context);
    final int greenIncidents = Provider.of<Tickets>(context)
        .incidents
        .where((element) => element.slaStatus == 'vert')
        .length;
    final int yellowIncidents = Provider.of<Tickets>(context)
        .incidents
        .where((element) => element.slaStatus == 'jaune')
        .length;
    final int redIncidents = Provider.of<Tickets>(context)
        .incidents
        .where((element) => element.slaStatus == 'rouge')
        .length; */

    final mediaQuery = MediaQuery.of(context);

    final screenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final welcomeText = Container(
      height: screenHeight * 0.13,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context).bienvenue,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          Text(
            '$_name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );

    Widget userInfoRow() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: screenHeight * 0.19,
          child: Row(
            children: [
              DashCard(
                icon: EvaIcons.wifi,
                title: 'Connexion',
                text: 'Online',
              ),
              DashCard(
                icon: EvaIcons.person_outline,
                title: AppLocalizations.of(context).donnes,
                text: '150 Mb',
              ),
            ],
          ),
        ),
      );
    }

    Widget workOrderCard() {
      return Container(
        height: screenHeight * 0.16,
        padding:
            EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: 25),
        decoration: BoxDecoration(
          color: Color.fromRGBO(242, 242, 242, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenHeight * 0.08,
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 113, 187, 0.4),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Icon(
                  EvaIcons.calendar_outline,
                  color: Color.fromRGBO(0, 113, 187, 1),
                  size: 26,
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    height: screenHeight * 0.04,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(112, 112, 112, 0.6),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  Text(
                    '$numberWorkorders',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> incidentsRow() {
      return [
        Row(
          children: [
            Text(
              'Incidents',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.03),
        Container(
          height: screenHeight * 0.18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    IncidentScreen.routeName,
                    arguments: 0,
                  );
                },
                child: DashTicketCard(
                  bgColor: Color.fromRGBO(4, 164, 5, 0.5),
                  iconColor: Color.fromRGBO(4, 164, 5, 1),
                  icon: EvaIcons.alert_triangle_outline,
                  number: greenIncidents,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    IncidentScreen.routeName,
                    arguments: 1,
                  );
                },
                child: DashTicketCard(
                  bgColor: Color.fromRGBO(255, 206, 86, 0.5),
                  iconColor: Color.fromRGBO(255, 206, 86, 1),
                  icon: EvaIcons.alert_triangle_outline,
                  number: yellowIncidents,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    IncidentScreen.routeName,
                    arguments: 2,
                  );
                },
                child: DashTicketCard(
                  bgColor: Color.fromRGBO(251, 91, 79, 0.5),
                  iconColor: Color.fromRGBO(251, 91, 79, 1),
                  icon: EvaIcons.alert_triangle_outline,
                  number: redIncidents,
                ),
              ),
            ],
          ),
        )
      ];
    }

    List<Widget> workOrderRow() {
      return [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Workorders',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: screenHeight * 0.03,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              WorkOrderScreen.routeName,
            );
          },
          child: workOrderCard(),
        ),
      ];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        margin: EdgeInsets.only(
          top: screenHeight * 0.02,
          bottom: screenHeight * 0.01,
        ),
        height: screenHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            welcomeText,
            SizedBox(
              height: screenHeight * 0.04,
            ),
            userInfoRow(),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            ...incidentsRow(),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            ...workOrderRow(),
          ],
        ),
      ),
    );
  }
}
