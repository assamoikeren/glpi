import 'package:flutter/material.dart';
import '../widgets/auth_form.dart';
import '../styles/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 15,
        ),
        decoration: Styles.loginBackground,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context).bienvenueTitle,
                  textAlign: TextAlign.center,
                  style: Styles.h1.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context).bienvenueMessage,
                  textAlign: TextAlign.center,
                  style: Styles.h2.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                AuthForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
