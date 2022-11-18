import 'package:fast_fueler_mobile_station/common/widgets/home_loading.dart';
import 'package:fast_fueler_mobile_station/models/active_queue.dart';
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

  @override
  Widget build(BuildContext context) {
    return activeQueues == null
        ? const HomeLoading()
        : Scaffold(
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
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () => HomeServices().logOut(context),
                ),
              ],
            ),
            body: Container(
              color: const Color.fromARGB(255, 237, 237, 237),
              child: activeQueues!.isEmpty
                  ? Center(
                      child: Text(
                      "No Ongoing queues to Display",
                      style: GoogleFonts.archivo(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: const Color.fromARGB(255, 27, 80, 80)),
                    ))
                  : GridView.builder(
                      itemCount: activeQueues!.length,
                      padding: const EdgeInsets.all(25),
                      itemBuilder: (context, index) {
                        final queueData = activeQueues![index];
                        return CategoryItem(
                            queueData.id,
                            queueData.fuelType,
                            (queueData.fuelType)!.contains("Petrol")
                                ? const Color.fromARGB(255, 214, 129, 0)
                                : Colors.green,
                            queueData.estimatedEndTime,
                            queueData.vehicleCount,
                            queueData.selectedAmount);
                      },
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400,
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 25,
                      ),
                    ),
            ),
          );
  }
}
