// ignore: unused_import
import 'dart:ffi';

import 'package:fast_fueler_mobile_station/common/widgets/home_loading.dart';
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
    setState(() {});
  }

  void refill(data, fType, qID, sID) {
    distributionServices.refill(
      context: context,
      filledAmount: _filledController.text.isEmpty
          ? data['quota']
          : _filledController.text,
      registrationNo: data['registrationNo'] ?? data['userID'],
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
    bool? check;
    var data = {};
    String? fType;
    String? qID;
    String? sID;
    var padding = 20.0;

    if (activeQueues != null) {
      for (var i = 0; i < activeQueues!.length; i++) {
        var q = activeQueues![i];
        if (q.requests.containsKey(reg)) {
          check = true;
          data = q.requests[reg];
          fType = q.fuelType;
          qID = q.id;
          sID = q.stationID;
          setState(() {});
          break;
        }
      }
      check ??= false;
    }

    return WillPopScope(
      onWillPop: () async {
        widget.screenClosed(); // Action to perform on back pressed
        return true;
      },
      child: check == null
          ? const HomeLoading()
          : check
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
                  backgroundColor: Colors.green[50],
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              padding, padding + 10, padding, 0),
                          child: Column(
                            children: [
                              Card(
                                color: Colors.teal[500],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Quota :  ${double.parse((data['quota']).toStringAsFixed(2))} L",
                                            style: GoogleFonts.lilitaOne(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.verified,
                                            size: 42,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            " ELIGIBLE ",
                                            style: GoogleFonts.titanOne(
                                                fontSize: 42,
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255)),
                                          ),
                                          const Icon(
                                            Icons.verified,
                                            size: 42,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "$fType",
                                        style: GoogleFonts.lilitaOne(
                                            fontSize: 35, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        padding * 2,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 30, 0, 30),
                                      child: Card(
                                        color: const Color.fromARGB(
                                            255, 51, 136, 54),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: nic == "org"
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .emoji_transportation_rounded,
                                                          color: Colors.white,
                                                          size: 27,
                                                        ),
                                                        Text(
                                                          "Organization Details",
                                                          style: GoogleFonts
                                                              .padauk(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Registration No: $reg",
                                                        style: GoogleFonts
                                                            .ubuntuCondensed(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .directions_car_filled_rounded,
                                                          color: Colors.white,
                                                          size: 27,
                                                        ),
                                                        Text(
                                                          "Vehicle Details",
                                                          style: GoogleFonts
                                                              .padauk(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 12, 0, 8),
                                                      child: Text(
                                                        "Registration No : $reg",
                                                        style: GoogleFonts
                                                            .ubuntuCondensed(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(0, 0, 0, 8),
                                                      child: Text(
                                                        "Owner NIC : $nic",
                                                        style: GoogleFonts
                                                            .ubuntuCondensed(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
                          child: Column(
                            children: [
                              const Divider(
                                thickness: 2,
                                color: Colors.black54,
                              ),
                              Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 0),
                                      child: Text(
                                          "If the Filled Amount is less than the Fuel Quota, Enter the Filled Amount!",
                                          style: GoogleFonts.ubuntuCondensed(
                                            fontSize: 13,
                                            color: Colors.black87,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: _filledController,
                                        validator: (value) {
                                          if (value != "") {
                                            if (int.parse(value!) >
                                                (data['quota'])) {
                                              return 'Cannot fill more than the Quota';
                                            }
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: 'Filled Amount',
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.red)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Colors.red),
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 20, 10, 0),
                                      child: SizedBox(
                                        height: 110,
                                        width: 170,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                elevation:
                                                    MaterialStateProperty.all(
                                                        20),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.teal[800]),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
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
                                              "  CONFIRM\nREFILMENT",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
              : Scaffold(
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
                    backgroundColor: Colors.red[900],
                  ),
                  backgroundColor: Colors.red[40],
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 250,
                          child: Card(
                            color: Colors.red[500],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Icon(
                                        Icons.dangerous_rounded,
                                        size: 42,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "     NOT\nELIGIBLE ",
                                        style: GoogleFonts.titanOne(
                                            fontSize: 45,
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                      const Icon(
                                        Icons.dangerous_rounded,
                                        size: 42,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // IconButton(
                        //     style: ButtonStyle(
                        //         shape: MaterialStateProperty.all(
                        //             const CircleBorder())),
                        //     color: Colors.black,
                        //     onPressed: () {
                        //       widget.screenClosed();
                        //       Navigator.pop(context);
                        //     },
                        //     icon: const Icon(
                        //       Icons.backspace_rounded,
                        //       color: Colors.black,
                        //     ))
                      ],
                    ),
                  ),
                ),
    );
  }
}
