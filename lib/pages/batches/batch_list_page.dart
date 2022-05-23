import 'package:api/api.dart';
import 'package:etra_flutter/app_config.dart';
import 'package:etra_flutter/services/session.dart';
import 'package:etra_flutter/widgets/custom/organization_logo.dart';
import 'package:etra_flutter/widgets/pagination_grid.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

/**
 * @author Gibah Joseph
 * email: gibahjoe@gmail.com
 * Dec, 2021
 **/
class BatchListPage extends StatefulWidget {
  const BatchListPage({Key? key}) : super(key: key);

  @override
  _BatchListPageState createState() => _BatchListPageState();
}

class _BatchListPageState extends State<BatchListPage> {
  GlobalKey<PaginationGridState> paginationGridKey = GlobalKey();
  late Session _session;

  @override
  Widget build(BuildContext context) {
    _session = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Batches'),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.microtask(
            () => paginationGridKey.currentState?.reloadData()),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - kToolbarHeight),
            child: PaginationGrid<TicketBatchPojo>(
              key: paginationGridKey,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, item) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xffc6c6c6),
                      width: 0.50,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0c38657f),
                        blurRadius: 3,
                        offset: Offset(0, 4),
                      ),
                    ],
                    color: Color(0xfffcfcfc),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Batch No.",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  item.batchNumber ?? '-',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Type",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    item.ticketType?.name ?? '-',
                                    style: TextStyle(
                                      color: Colors.black38,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: OrganizationLogo(
                                height: 30,
                                borderRadius: BorderRadius.zero,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${item.numberOfTicketsInBatch ?? '-'}',
                                    style: TextStyle(
                                      color: Color(0xff094678),
                                      fontSize: 18,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Tickets",
                                    style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item.soldCount ?? '-'}",
                                  style: TextStyle(
                                    color: Color(0xff34b114),
                                    fontSize: 18,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "Sold",
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              onEmpty: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.remove_circle,
                      color: Colors.amber,
                      size: 60,
                    ),
                    Text(
                      'No tickets issued',
                      textScaleFactor: 1.1,
                    ),
                  ],
                ),
              ),
              onError: (e) {
                print(e);
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.red,
                        size: 60,
                      ),
                      Text(
                        'Oops, something went wrong',
                        textScaleFactor: 1.3,
                      ),
                    ],
                  ),
                );
              },
              onPageLoading: Center(
                child: JumpingDotsProgressIndicator(
                  fontSize: 50,
                  color: appPrimaryColor,
                ),
              ),
              onLoading: Center(
                child: JumpingDotsProgressIndicator(
                  fontSize: 50,
                  color: appPrimaryColor,
                ),
              ),
              pageFetch: (currentSize) {
                return etraApi
                    .getTicketBatchControllerApi()
                    .searchTicketBatch(
                        organizationId:
                            _session.currentWorkspace?.organizationId,
                        appUserId: _session.appUser?.id ?? -1,
                        order: 'DESC',
                        status: 'ACTIVE',
                        offset: currentSize,
                        limit: 20,
                        orderColumn: 'createdAt')
                    .then((value) => value.data?.results?.toList() ?? []);
              },
            ),
          ),
        ),
      ),
    );
  }
}
