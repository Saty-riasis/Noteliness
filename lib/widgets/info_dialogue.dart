import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class MyInfoDialog extends StatelessWidget {
  const MyInfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 330,
        height: 160,
        decoration: BoxDecoration(
          color: myColors.DarkGrey,
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const MyTitles(title: "Coded by", value: "Team Saty-riasis"),
            Expanded(child: Image.asset('assets/images/logo.png'),)
          ],
        ),
      ),
    );
  }
}

class MyTitles extends StatelessWidget {
  final String title;
  final String value;

  const MyTitles({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "$title -",
            style: GoogleFonts.nunito(
                color: myColors.LightGrey,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
          Text(
            value,
            style: GoogleFonts.nunito(
                color: myColors.LightGrey,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),
        ],
      ),
    );
  }
}
