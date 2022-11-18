import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CategoryItem extends StatelessWidget {
  final String? id;
  final String? title;
  final Color color;
  final String qet;
  final String vehicles;
  final String quata;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  CategoryItem(
      this.id, this.title, this.color, this.qet, this.vehicles, this.quata);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      '/category-meals',
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 10,
      shadowColor: const Color.fromARGB(255, 4, 4, 4),
      // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 0, 5),
                  child: Row(
                    children: [
                      Text(
                        "$title",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Queue end Time:${(DateFormat.yMEd().add_jms().format(DateTime.parse(qet))).split(',')[1]}",
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 25, 0, 0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.departure_board_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                      Text(
                        vehicles,
                        style: GoogleFonts.bungee(
                          fontSize: 30,
                          color: const Color.fromARGB(255, 255, 221, 134),
                        ),
                      ),
                      Text(
                        " vehicles",
                        style: GoogleFonts.oswald(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.bar_chart_rounded,
                          size: 25,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          "$quata L",
                          style: GoogleFonts.lilitaOne(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 255, 221, 134)),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      " remaining",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
