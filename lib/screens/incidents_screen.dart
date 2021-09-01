import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../widgets/aucun_ticket.dart';
import '../widgets/ticket_home_card.dart';
import '../icons/eva_icons_icons.dart';
//import '../models/ticket.dart';
import '../widgets/side_menu.dart';
//import '../providers/tickets_provider.dart';
import '../database/moor_database.dart';
import '../database/converts.dart';

class IncidentScreen extends StatefulWidget {
  static const routeName = '/Incidents';

  @override
  _IncidentScreenState createState() => _IncidentScreenState();
}

class _IncidentScreenState extends State<IncidentScreen> {
  //var _isloading = false;
  int _selectedPageIndex = 0;
  int _currentIndex = 0;
  int _index = 0;

  void selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      _currentIndex = index;
    });
  }

  final appBar = AppBar(
    centerTitle: true,
    title: Text('Incidents'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(25),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<LocalTicketDao>(context);
    //ticketsData.incidents;
    if (_index == 0) {
      final index = ModalRoute.of(context).settings.arguments as int;
      selectedPage(index);
      setState(() {
        _index = 1;
      });
    }

    final greenIncidentList = dao.watchAllTicketBySla('vert');
    //allTickets.where((element) => element.slaStatus == 'vert').toList();
    final yellowIncidentsList = dao.watchAllTicketBySla('jaune');
    //allTickets.where((element) => element.slaStatus == 'jaune').toList();
    final redIncidentList = dao.watchAllTicketBySla('rouge');
    //allTickets.where((element) => element.slaStatus == 'rouge').toList();

    final List<Widget> pages = [
      buildIncidentScreen(
        incidents: greenIncidentList,
        slaColor: Color.fromRGBO(4, 164, 5, 0.4),
        slaTextColor: Color.fromRGBO(4, 164, 5, 1),
      ),
      buildIncidentScreen(
        incidents: yellowIncidentsList,
        slaColor: Color.fromRGBO(255, 206, 86, 0.4),
        slaTextColor: Color.fromRGBO(255, 206, 86, 1),
      ),
      buildIncidentScreen(
        incidents: redIncidentList,
        slaColor: Color.fromRGBO(251, 91, 79, 0.4),
        slaTextColor: Color.fromRGBO(251, 91, 79, 1),
      ),
    ];

    return Scaffold(
      appBar: appBar,
      drawer: Drawer(
        child: SideMenu(),
      ),
      body:
          /* _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          :  */
          pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectedPage,
        currentIndex: _currentIndex,
        unselectedItemColor: Color.fromRGBO(0, 113, 187, 0.3),
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.alert_triangle_outline,
            ),
            label: 'Vert',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              EvaIcons.alert_triangle_outline,
            ),
            label: 'Jaune',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.alert_triangle_outline),
            label: 'Rouge',
          ),
        ],
      ),
    );
  }
}

Widget buildIncidentScreen(
    {Stream<List<LocalTicket>> incidents, Color slaColor, Color slaTextColor}) {
  return /* incidents.isEmpty
      ? AucunTicket() */
      /* Column(
    children: [
      SizedBox(
        height: 30,
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child:  */
      TicketHomeCard(
    ticketList: incidents,
    slaColor: slaColor,
    slaTextColor: slaTextColor,
  );
  //       ),
  //     ),
  //   ],
  // );
}
/* 
Widget buildIncidentScreen (
    {Stream<List<LocalTicket>> incidents, Color slaColor, Color slaTextColor}) {
  return await incidents.isEmpty
      ? AucunTicket()
      : Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: TicketHomeCard(
                  ticketList: incidents,
                  slaColor: slaColor,
                  slaTextColor: slaTextColor,
                ),
              ),
            ),
          ],
        );
} */
