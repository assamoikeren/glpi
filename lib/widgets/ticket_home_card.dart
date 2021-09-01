import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:intl/intl.dart';
import '../models/ticket.dart';
import '../screens/ticket_details_screen.dart';
import '../utils/http.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../utils/constant.dart';
import '../database/moor_database.dart';
import '../database/converts.dart';
import '../widgets/aucun_ticket.dart';
import '../widgets/refresh.dart';
import '../providers/tickets_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TicketHomeCard extends StatefulWidget {
  const TicketHomeCard({
    Key key,
    @required this.ticketList,
    this.slaColor,
    this.slaTextColor,
  }) : super(key: key);

  final Stream<List<LocalTicket>> ticketList;
  final Color slaColor;
  final Color slaTextColor;

  @override
  _TicketHomeCardState createState() => _TicketHomeCardState();
}

class _TicketHomeCardState extends State<TicketHomeCard> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  Future loadList() async {
    keyRefresh.currentState?.show();
    await Future.delayed(Duration(milliseconds: 4000));

    Provider.of<Tickets>(context, listen: false).fetchTickets(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext scontext) {
    return StreamBuilder(
        stream: widget.ticketList,
        builder: (context, AsyncSnapshot<List<LocalTicket>> snapshot) {
          final tickets = snapshot.data == null ? [] : snapshot.data.toList();
          return tickets.isEmpty
              ? AucunTicket()
              : Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        child: RefreshWidget(
                          keyRefresh: keyRefresh,
                          onRefresh: loadList,
                          child: ListView.builder(
                              itemCount: tickets.length,
                              itemBuilder: (context, i) {
                                /* tickets[i].steps != null
                                    ? print('N°1 : ${tickets[1].steps}')
                                    : print('rien'); */
                                Ticket ticket = Converts.convert(tickets[i]);
                                /* ticket.task != null
                                    ? print('N°1 : ${ticket.task[0].taskName}')
                                    : print('rien'); */
                                return TicketCard(
                                    ticket: ticket, widget: widget);
                              }),
                        ),
                      ),
                    ),
                  ],
                );
        });
  }
}

class TicketCard extends StatefulWidget {
  const TicketCard({
    Key key,
    @required this.widget,
    @required this.ticket,
  }) : super(key: key);

  final TicketHomeCard widget;
  final Ticket ticket;

  @override
  _TicketCardState createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<LocalTicketDao>(context, listen: false);
    Future<void> changeNewState(int id) async {
      var http = getHttp();
      String token =
          await Provider.of<AuthProvider>(context, listen: false).getToken();
      try {
        final response =
            await http.put(Uri.parse('$API_URL_WALIX/changeNew/$id'), headers: {
          'Authorization': 'Bearer $token',
        });
        print('Done');
      } catch (e) {
        print(e);
      }
    }

    return widget.ticket.ticketIsNew
        ? Badge(
            position: BadgePosition(end: 15, top: 10),
            badgeColor: Color.fromRGBO(249, 164, 9, 1),
            badgeContent: Icon(
              Icons.notifications_active_outlined,
              color: Colors.white,
              size: 18,
            ),
            child: InkWell(
              onTap: () {
                print(widget.ticket.id);
                if (widget.ticket.ticketIsNew) {
                  widget.ticket.toggleIsNew();
                  dao.updateTicketNew(widget.ticket.id);
                  setState(() {});
                  changeNewState(widget.ticket.id);
                }
                Navigator.pushNamed(
                  context,
                  TicketDetailsScreen.routeName,
                  arguments: widget.ticket,
                );
              },
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    CardText(
                      title: AppLocalizations.of(context).numero,
                      text: '${widget.ticket.id}',
                    ),
                    CardText(
                      title: AppLocalizations.of(context).demandeur,
                      text: '${widget.ticket.demandeur}',
                    ),
                    CardText(
                      title: AppLocalizations.of(context).titre,
                      text: '${widget.ticket.titre}',
                    ),
                    CardText(
                      title: AppLocalizations.of(context).categorie,
                      text: '${widget.ticket.categorie}',
                    ),
                    CardText(
                      title: AppLocalizations.of(context).technicien,
                      text: '${widget.ticket.technicien}',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      widget.ticket.type == TicketType.workorders
                          ? widget.ticket.dateDebut != null
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(4, 164, 5, 0.4),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${DateFormat('dd/MM/yyyy').format(widget.ticket.dateDebut)}',
                                    style: TextStyle(
                                      color: Color.fromRGBO(4, 164, 5, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: 0,
                                )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 113, 187, 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${DateFormat('dd/MM/yyyy').format(widget.ticket.dateCreation)}',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                      SizedBox(
                        width: 5,
                      ),
                      widget.ticket.type == TicketType.workorders
                          ? widget.ticket.dateFin != null
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(251, 91, 79, 0.4),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${DateFormat('dd/MM/yyyy').format(widget.ticket.dateFin)}',
                                    style: TextStyle(
                                      color: Color.fromRGBO(251, 91, 79, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                )
                              : SizedBox(width: 0)
                          : SizedBox(width: 0),
                      widget.widget.slaColor == null
                          ? SizedBox(width: 0)
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 20),
                              decoration: BoxDecoration(
                                color: widget.widget.slaColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${widget.ticket.sla}',
                                style: TextStyle(
                                  color: widget.widget.slaTextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                    ])
                  ],
                ),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                TicketDetailsScreen.routeName,
                arguments: widget.ticket,
              );
            },
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(242, 242, 242, 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  CardText(
                    title: AppLocalizations.of(context).numero,
                    text: '${widget.ticket.id}',
                  ),
                  CardText(
                    title: AppLocalizations.of(context).demandeur,
                    text: '${widget.ticket.demandeur}',
                  ),
                  CardText(
                    title: AppLocalizations.of(context).titre,
                    text: '${widget.ticket.titre}',
                  ),
                  CardText(
                    title: AppLocalizations.of(context).categorie,
                    text: '${widget.ticket.categorie}',
                  ),
                  CardText(
                    title: AppLocalizations.of(context).technicien,
                    text: '${widget.ticket.technicien}',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    widget.ticket.type == TicketType.workorders
                        ? widget.ticket.dateDebut != null
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(4, 164, 5, 0.4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${DateFormat('dd/MM/yyyy').format(widget.ticket.dateDebut)}',
                                  style: TextStyle(
                                    color: Color.fromRGBO(4, 164, 5, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 0,
                              )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 113, 187, 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${DateFormat('dd/MM/yyyy').format(widget.ticket.dateCreation)}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 5,
                    ),
                    widget.ticket.type == TicketType.workorders
                        ? widget.ticket.dateFin != null
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(251, 91, 79, 0.4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${DateFormat('dd/MM/yyyy').format(widget.ticket.dateFin)}',
                                  style: TextStyle(
                                    color: Color.fromRGBO(251, 91, 79, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            : SizedBox(width: 0)
                        : SizedBox(width: 0),
                    widget.widget.slaColor == null
                        ? SizedBox(width: 0)
                        : Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 20),
                            decoration: BoxDecoration(
                              color: widget.widget.slaColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${widget.ticket.sla}',
                              style: TextStyle(
                                color: widget.widget.slaTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                  ])
                ],
              ),
            ),
          );
  }
}

class CardText extends StatelessWidget {
  final String title;
  final String text;
  CardText({this.title, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.only(bottom: 8),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: '$title : ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'QuickSand',
                fontSize: 14,
              ),
            ),
            TextSpan(
                text: '$text',
                style: TextStyle(
                  color: Color.fromRGBO(112, 112, 112, 1),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'QuickSand',
                  fontSize: 14,
                )),
          ]),
        ));
  }
}
