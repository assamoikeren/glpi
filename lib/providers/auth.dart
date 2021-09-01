import 'package:flutter/material.dart';
import '../utils/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../providers/tickets_provider.dart';
import '../utils/constant.dart';
import '../screens/auth_screen.dart';
import '../screens/dashboard_screen.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../database/moor_database.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(
      String name, String password, BuildContext context, GlobalKey key) async {
    dialog(context, key);
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      var http = getHttp();
      try {
        final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
        final deviceData = await deviceInfoPlugin.androidInfo;
        print(deviceData.androidId);
        final response = await http
            .post(Uri.parse('$API_URL_WALIX/login'), body: {
              'name': name,
              'password': password,
              'deviceId': deviceData.androidId,
              'marque': deviceData.manufacturer,
              'model': deviceData.model
            }, headers: {
              'Accept': 'application/json',
            })
            .whenComplete(() => {http.close()})
            .timeout(
              const Duration(seconds: 120),
            );

        if (response.statusCode == 200) {
          Map<String, dynamic> apiResponse = json.decode(response.body);
          String token = apiResponse['token'];
          String lastName = apiResponse['user']['lastname'];
          String firstName = apiResponse['user']['firstname'];
          String identifiant = apiResponse['user']['identifiant'];
          String profil = apiResponse['user']['profil'];
          int id = apiResponse['user']['id'];
          //messaging.subscribeToTopic('camer_user_$id');
          messaging.subscribeToTopic('user_$id');
          saveToken(token);
          saveId(id);
          saveLastName(lastName);
          saveFirstName(firstName);
          saveIdentifiant(identifiant);
          saveProfil(profil);
          saveConnect();
          await Provider.of<Tickets>(context, listen: false)
              .fetchTickets(context);
          notifyListeners();
          Navigator.pushNamedAndRemoveUntil(
              context, DashboardScreen.routeName, (r) => false);
          // Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
          //Navigator.popAndPushNamed(context, DashboardScreen.routeName);
          /* _isAuthenticated = true; */
          // Navigator.of(key.currentContext, rootNavigator: true).pop();
        }

        if (response.statusCode == 401) {
          Navigator.of(key.currentContext, rootNavigator: true).pop();
          Map<String, dynamic> apiResponse = json.decode(response.body);
          showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              backgroundColor: Color.fromRGBO(197, 108, 113, 1),
              title: new Text(
                'Oups !',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: new Text(
                apiResponse['errors'] == '1'
                    ? AppLocalizations.of(context).connexionIdErr
                    : AppLocalizations.of(context).connexionImeiErr,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          );
        }
      } on TimeoutException catch (_) {
        Navigator.of(key.currentContext, rootNavigator: true).pop();
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            backgroundColor: Color.fromRGBO(197, 108, 113, 1),
            title: new Text(
              AppLocalizations.of(context).desole,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: new Text(
              AppLocalizations.of(context).accesServeur,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        );
      } catch (error) {
        Navigator.of(key.currentContext, rootNavigator: true).pop();
        SweetAlert.show(context,
            title: AppLocalizations.of(context).desole,
            subtitle: AppLocalizations.of(context).erreurProduite,
            style: SweetAlertStyle.error);
      }
    } else {
      Navigator.of(context).pop();
      SweetAlert.show(context,
          title: "Oups!",
          subtitle: AppLocalizations.of(context).pasDeConnexion,
          style: SweetAlertStyle.error);
    }
  }

  saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  saveId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', id);
  }

  saveLastName(String lastName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastName', lastName);
  }

  saveConnect() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('connected', true);
  }

  saveFirstName(String firstName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
  }

  saveIdentifiant(String identifiant) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('identifiant', identifiant);
  }

  saveProfil(String profil) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profil', profil);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String> getLastName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('lastName');
  }

  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    final first = prefs.getString('firstName');
    final prefs2 = await SharedPreferences.getInstance();
    final last = prefs2.getString('lastName');
    return '$first $last';
  }

  Future<String> getIdentifiant() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('identifiant');
  }

  Future<String> getProfil() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('profil');
  }

  Future<int> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }

  logout(int id, BuildContext context) async {
    //messaging.unsubscribeFromTopic('user_$id');
    final dao = Provider.of<LocalTicketDao>(context, listen: false);
    dao.feelingLazy();
    Navigator.pushNamedAndRemoveUntil(
        context, AuthScreen.routeName, (r) => false);
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
