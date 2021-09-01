import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Styles {
  //login page style
  static BoxDecoration loginBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [const Color(0xFF0071BB), const Color(0XFF39A2D1)],
    ),
  );

  static TextStyle h1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2 = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static InputDecoration input = InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 10),
    filled: true,
    fillColor: Colors.white,
    prefixIconConstraints: BoxConstraints(
      minWidth: 75,
    ),
    hintStyle: TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide.none,
    ),
  );

  Widget buildPrefixIcon(IconData icon, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
      ),
      child: Icon(
        icon,
        color: Theme.of(context).accentColor,
        size: 20.0,
      ),
    );
  }
}

Widget confirmAlertDialog(
    {Function no,
    Function yes,
    String title,
    String subtitle,
    BuildContext context}) {
  return AlertDialog(
    actionsPadding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
    title: new Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    content: new Text(
      subtitle,
      style: TextStyle(
        fontSize: 16,
      ),
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: no,
        child: new Text(
          AppLocalizations.of(context).btnNo,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: 'QuickSand',
          ),
        ),
      ),
      new TextButton(
        onPressed: yes,
        child: new Text(
          AppLocalizations.of(context).btnOui,
          style: TextStyle(
            color: Colors.green,
            fontFamily: 'QuickSand',
          ),
        ),
      ),
    ],
  );
}

Widget buildRoundedButton(
    {IconData icon, Function onPress, BuildContext context}) {
  return Container(
    height: 58,
    width: 58,
    padding: EdgeInsets.all(0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 8,
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        primary: Theme.of(context).accentColor,
      ),
      onPressed: onPress,
      child: Icon(
        icon,
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
    ),
  );
}
