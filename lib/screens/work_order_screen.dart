import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../widgets/aucun_ticket.dart';
import '../providers/tickets_provider.dart';
import '../widgets/ticket_home_card.dart';
import '../widgets/side_menu.dart';
import '../database/moor_database.dart';

class WorkOrderScreen extends StatefulWidget {
  static const routeName = '/workOrders';

  @override
  _WorkOrderScreenState createState() => _WorkOrderScreenState();
}

class _WorkOrderScreenState extends State<WorkOrderScreen> {
  var _isloading = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      title: Text('Workorders'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
    );

    final ticketsData = Provider.of<LocalTicketDao>(context);
    final workorderList = ticketsData.watchAllTicketByType(2);

    return Scaffold(
      appBar: appBar,
      drawer: Drawer(
        child: SideMenu(),
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TicketHomeCard(
              ticketList: workorderList,
            ), /*  workorderList.isEmpty
              ? AucunTicket()
              : */
      // Column(
      //     children: [
      //       SizedBox(
      //         height: 30,
      //       ),
      //       Expanded(
      //         child: Container(
      //           padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      //           child: TicketHomeCard(
      //             ticketList: workorderList,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
    );
  }
}
