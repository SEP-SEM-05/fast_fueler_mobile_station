import 'package:fast_fueler_mobile_station/screens/distribution/services/distribution_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../models/active_queue.dart';
import '../home/services/home_services.dart';

class DistributionScreen extends StatefulWidget {
  static const String routeName = '/distribution';

  final Barcode value;
  final Function() screenClosed;

  const DistributionScreen({
    Key? key,
    required this.screenClosed,
    required this.value,
  }) : super(key: key);

  @override
  State<DistributionScreen> createState() => _DistributionScreenState();
}

class _DistributionScreenState extends State<DistributionScreen> {
  List<ActiveQueue>? activeQueues;
  final HomeServices homeServices = HomeServices();
  final DistributionServices distributionServices = DistributionServices();
  final TextEditingController _filledController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _filledController.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchAllActiveQueues();
  }

  fetchAllActiveQueues() async {
    activeQueues = await homeServices.fetchAllActiveQueues(context);
    debugPrint(activeQueues![1]
        .requests
        .containsKey(widget.value.code!.split('&')[0])
        .toString());
    setState(() {});
  }

  void refill(data, fType, qID, sID) {
    distributionServices.refill(
      context: context,
      filledAmount: _filledController.text.isEmpty
          ? data['quota']
          : _filledController.text,
      registrationNo:
          data['registrationNo'] ?? data['userID'],
      stationRegNo: sID,
      queueID: qID,
      fuelType: fType,
    );
  }

  @override
  Widget build(BuildContext context) {
    var reg = widget.value.code!.split("&")[0];
    var nic = widget.value.code!.split("&").length > 1
        ? widget.value.code!.split("&")[1]
        : 'org';
    var check = false;
    var data = {};
    String? fType;
    String? qID;
    String? sID;

    if (activeQueues != null) {
      for (var i = 0; i < activeQueues!.length; i++) {
        var q = activeQueues![i];
        if (q.requests.containsKey(reg)) {
          check = true;
          data = q.requests[reg];
          fType = q.fuelType;
          qID = q.id;
          sID = q.stationID;
          break;
        }
      }
    }

    // print('menna data');
    // print(check);
    // print(data);
    // print(fType);
    // print(qID);

    return WillPopScope(
      onWillPop: () async {
        widget.screenClosed(); // Action to perform on back pressed
        return true;
      },
      child: check
          ? Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    widget.screenClosed();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_outlined,
                  ),
                ),
                title: Text(
                  "Fast Fueler",
                  style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: const Color.fromARGB(255, 255, 255, 255)),
                ),
                centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 51, 136, 54),
              ),
              backgroundColor: const Color.fromARGB(255, 246, 243, 236),
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Card(
                                color: const Color.fromARGB(255, 51, 136, 54),
                                elevation: 10,
                                shadowColor: const Color.fromARGB(255, 4, 4, 4),
                                // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.verified,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        " Eligible",
                                        style: GoogleFonts.rubikBubbles(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35,
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.grey,
                                elevation: 10,
                                shadowColor: const Color.fromARGB(255, 4, 4, 4),
                                // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Quota",
                                        style: GoogleFonts.lilitaOne(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "${double.parse((data['quota']).toStringAsFixed(2))} L",
                                        style: GoogleFonts.lilitaOne(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 152, 66, 66)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Card(
                                  color: fType!.contains("Petrol")
                                      ? const Color.fromARGB(255, 214, 129, 0)
                                      : Colors.green,
                                  elevation: 10,
                                  shadowColor:
                                      const Color.fromARGB(255, 4, 4, 4),
                                  // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      fType,
                                      style: GoogleFonts.russoOne(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Card(
                                  color: nic.contains("org")
                                      ? const Color.fromARGB(255, 118, 101, 83)
                                      : const Color.fromARGB(255, 86, 116, 86),
                                  elevation: 10,
                                  shadowColor:
                                      const Color.fromARGB(255, 4, 4, 4),
                                  // margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: nic != "org"
                                        ? Column(
                                            children: [
                                              Text(
                                                "Organization Details",
                                                style: GoogleFonts.russoOne(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "➤ Registration No: $reg",
                                                  style: GoogleFonts
                                                      .ubuntuCondensed(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Vehicle Details",
                                                style: GoogleFonts.russoOne(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 12, 0, 8),
                                                child: Text(
                                                  "➤ Registration No: $reg",
                                                  style: GoogleFonts
                                                      .ubuntuCondensed(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 8),
                                                child: Text(
                                                  "➤ Owner NIC: $nic",
                                                  style: GoogleFonts
                                                      .ubuntuCondensed(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 25, 20, 0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _filledController,
                                    onChanged: null,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Filled Amount',
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 20, 20, 20))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 20, 20, 20))),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            borderSide: const BorderSide(
                                                color: Colors.red)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                            borderSide: const BorderSide(color: Colors.red))),
                                  ),
                                ),
                                Text(
                                  "If Filled Amount less than the Fuel Quota, Enter the Filled Amount!",
                                  style: GoogleFonts.ubuntuCondensed(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 79, 79, 79)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 60, 10, 0),
                                  child: SizedBox(
                                    height: 80,
                                    width: 600,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromARGB(
                                                        255, 43, 144, 144)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ))),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            refill(data, fType, qID, sID);
                                          } else {
                                            debugPrint("not ok");
                                          }
                                        },
                                        child: const Text(
                                          "CONFIRM REFILMENT",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
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
              ))
          : Scaffold(),
    );
  }
}
