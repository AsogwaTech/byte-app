import 'package:etra_flutter/app_config.dart';
import 'package:etra_flutter/image_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ValidationHistoryCard extends StatefulWidget {
  const ValidationHistoryCard({Key? key}) : super(key: key);

  @override
  _ValidationHistoryCardState createState() => _ValidationHistoryCardState();
}

class _ValidationHistoryCardState extends State<ValidationHistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      height: 100,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(
          250,
          250,
          250,
          1,
        ),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color.fromRGBO(
            225,
            225,
            225,
            1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            ImageConstant.SOLD_ICON,
            height: 40,
            width: 40,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Ticket No.',
                        style: GoogleFonts.openSans(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '00003417',
                        style: GoogleFonts.openSans(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bus Ticket',
                        style: GoogleFonts.openSans(
                          color: appPrimaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '01 Nov 2021, 09:01',
                        style: GoogleFonts.openSans(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Vehicle No.',
                  style: GoogleFonts.openSans(
                    color: appPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'RSH-24-AJ',
                  style: GoogleFonts.openSans(
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '₦150',
                        style: GoogleFonts.openSans(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
