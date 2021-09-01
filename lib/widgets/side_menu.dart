import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../icons/eva_icons_icons.dart';
import '../screens/dashboard_screen.dart';
import '../screens/incidents_screen.dart';
import '../screens/work_order_screen.dart';
import '../providers/auth.dart';
import '../styles/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String _name;
  String _profil;
  int _id;

  Future<void> getName() async {
    final name =
        await Provider.of<AuthProvider>(context, listen: false).getName();
    final identifiant =
        await Provider.of<AuthProvider>(context, listen: false).getProfil();
    final id = await Provider.of<AuthProvider>(context, listen: false).getId();
    setState(() {
      _name = name;
      _profil = identifiant;
      _id = id;
    });
  }

  Widget builListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              icon,
              size: 20,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ],
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext widgetContext) {
    getName();
    final mediaQuery = MediaQuery.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.20,
          child: drawerHeader(context: context, name: _name, profil: _profil),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.8,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              //Dashboard listTile
              builListTile(
                'Dashboard',
                EvaIcons.activity_outline,
                () {
                  Navigator.popAndPushNamed(
                    context,
                    DashboardScreen.routeName,
                  );
                },
              ),
              //Incidents listTile
              builListTile(
                'Incidents',
                EvaIcons.alert_triangle_outline,
                () {
                  Navigator.popAndPushNamed(
                    context,
                    IncidentScreen.routeName,
                    arguments: 0,
                  );
                },
              ),
              //workorders listTile
              builListTile(
                'Workorders',
                EvaIcons.calendar_outline,
                () {
                  Navigator.popAndPushNamed(
                    context,
                    WorkOrderScreen.routeName,
                  );
                },
              ),
              Divider(
                height: 40,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              //déconnexion listile
              builListTile(
                AppLocalizations.of(context).deconnexion,
                EvaIcons.log_out_outline,
                () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => confirmAlertDialog(
                        no: () {
                          Navigator.of(context).pop();
                        },
                        yes: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .logout(_id, widgetContext);
                        },
                        title: AppLocalizations.of(context).etesVousSur,
                        subtitle: AppLocalizations.of(context).veuxDeconnecter,
                        context: context),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

Widget drawerHeader({BuildContext context, String name, String profil}) {
  return Container(
    padding: EdgeInsets.zero,
    /*  width: MediaQuery.of(context).size.width * 1, */
    child: DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      // child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$name',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '$profil',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
