import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteliness/model/wall_entry.dart';
import 'package:noteliness/providers/wall_screen_provider.dart';
import 'package:noteliness/screens/add_wall_screen_entry.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../widgets/appbar.dart';
import '../widgets/floating_button.dart';
import '../widgets/info_dialogue.dart';
import '../widgets/note_card.dart';
import '../widgets/note_not_found.dart';
import '../widgets/progress_bar.dart';

class WallScreen extends StatefulWidget{
  @override
  State<WallScreen> createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  Future<List<wall_entry>>? notes;
  TextEditingController _searchTextController = TextEditingController();
  Widget myMainAppBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Notes",
            style: GoogleFonts.nunito(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 43),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyButton(
                icon: const Icon(Icons.search_outlined),
                click: () {

                },
              ),
              const SizedBox(
                width: 20,
              ),
              MyButton(
                icon: const Icon(Icons.info_outline_rounded),
                click: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => const MyInfoDialog());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget roundedSearchInput() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      padding: const EdgeInsets.all(14),
      child: TextField(
        controller: _searchTextController,
        onChanged: (searchedNotes) {
        },
        style: GoogleFonts.nunito(
            color: myColors.White,
            fontWeight: FontWeight.normal,
            fontSize: 18),
        cursorColor: myColors.White,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {

            },
            icon: const Icon(
              Icons.clear,
              color: myColors.White,
            ),
          ),
          filled: true,
          fillColor: myColors.Grey,
          hintText: 'Search by the keyword...',
          hintStyle: GoogleFonts.nunito(
              color: myColors.White,
              fontWeight: FontWeight.normal,
              fontSize: 16),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    wallScreenProvider provider = Provider.of<wallScreenProvider>(context);
    notes = wallScreenProvider().getEntries();
    return Scaffold(
      backgroundColor: myColors.DarkGrey,
      floatingActionButton: MyFloatingButton(
        clk: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => addWallScreenEntry());
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            myMainAppBar(),
            FutureBuilder(
              future: notes as Future<List<wall_entry>>,
              builder: (BuildContext context, AsyncSnapshot<List<wall_entry>> notes) {
                if (notes.hasData) {
                  if (_searchTextController.text.isNotEmpty) {
                    return const NoteNotFound();
                  } else {
                    return Expanded(
                      child: RefreshIndicator(
                        backgroundColor: myColors.Grey,
                        color: myColors.White,
                        onRefresh: () async {
                          setState(() {
                          });
                        },
                        child: ListView.builder(
                          itemCount: notes.data?.length,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return NoteCard(entry: notes.data![index]);
                          },
                        ),
                      ),
                    );
                  }
                } else {
                  return const MyProgressBar();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}