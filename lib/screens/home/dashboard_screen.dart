import 'package:fast_fueler_mobile_station/models/active_queue.dart';
import 'package:fast_fueler_mobile_station/models/category.dart';
import 'package:fast_fueler_mobile_station/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fast_fueler_mobile_station/screens/home/services/home_services.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<ActiveQueue>? activeQueues;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchAllActiveQueues();
  }

  fetchAllActiveQueues() async {
    activeQueues = await homeServices.fetchAllActiveQueues(context);
    setState(() {});
  }

  final DUMMY_CATEGORIES = const [
    Category(
      id: 'c2',
      title: 'Super Diesel',
      color: Colors.green,
      qet: "2022/11/17 02:13:00",
      vehicles: "12",
      quata: "293",
    ),
    Category(
      id: 'c4',
      title: 'Petrol 92 Octane',
      color: Color.fromARGB(255, 214, 129, 0),
      qet: "2022/11/17 02:13:00",
      vehicles: "13",
      quata: "103",
    ),
    Category(
      id: 'c4',
      title: 'Petrol 95 Octane',
      color: Color.fromARGB(255, 214, 129, 0),
      qet: "2022/11/17 02:13:00",
      vehicles: "3",
      quata: "58",
    ),
    Category(
      id: 'c2',
      title: 'Super Diesel',
      color: Colors.green,
      qet: "2022/11/17 02:13:00",
      vehicles: "5",
      quata: "126",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.local_gas_station_rounded,
          size: 28,
        ),
        title: Text(
          "Fast Fueler",
          style: GoogleFonts.pacifico(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: const Color.fromARGB(255, 255, 255, 255)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 22, 22, 27),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () => HomeServices().logOut(context),
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 237, 237, 237),
        child: GridView(
          padding: const EdgeInsets.all(25),
          children: DUMMY_CATEGORIES
              .map(
                (catData) => CategoryItem(
                    catData.id,
                    catData.title,
                    catData.color,
                    catData.qet,
                    catData.vehicles,
                    catData.quata),
              )
              .toList(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 2.5,
            mainAxisSpacing: 25,
          ),
        ),
      ),
    );
  }
}
