import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AucunTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/notFound.png',
            height: 90,
            width: 90,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            AppLocalizations.of(context).pasDeTicket,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
