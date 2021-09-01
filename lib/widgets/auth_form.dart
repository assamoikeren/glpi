import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../icons/eva_icons_icons.dart';
import '../styles/styles.dart';
import '../providers/auth.dart';
import '../utils/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    Key key,
  }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  String _name;
  String _password;

  Future<void> submitForm() async {
    await Provider.of<AuthProvider>(context, listen: false)
        .login(_name, _password, context, _keyLoader);
  }

  @override
  Widget build(BuildContext context) {
    final connexionBtn = ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        primary: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          submitForm();
        }
      },
      child: Text(
        AppLocalizations.of(context).connexion,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                RegExp(regex),
              ),
            ],
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.text,
            decoration: Styles.input.copyWith(
              hintText: AppLocalizations.of(context).identifiant,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: Icon(
                  EvaIcons.edit_outline,
                  color: Theme.of(context).accentColor,
                  size: 20.0,
                ),
              ),
            ),
            validator: (value) => value.isEmpty
                ? AppLocalizations.of(context).entrerIdentifiant
                : null,
            onSaved: (value) => _name = value,
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                RegExp(regex),
              ),
            ],
            textAlignVertical: TextAlignVertical.center,
            obscureText: true,
            decoration: Styles.input.copyWith(
              hintText: AppLocalizations.of(context).motDePasse,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: Icon(
                  EvaIcons.lock_outline,
                  color: Theme.of(context).accentColor,
                  size: 20.0,
                ),
              ),
            ),
            validator: (value) => value.isEmpty
                ? AppLocalizations.of(context).entrerMotDePasse
                : null,
            onSaved: (value) => _password = value,
          ),
          SizedBox(
            height: 45,
          ),
          connexionBtn,
        ],
      ),
    );
  }
}
