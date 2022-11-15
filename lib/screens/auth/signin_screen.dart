import 'package:fast_fueler_mobile_station/screens/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../widgets/dashboard.dart';
import '../../models/station.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SigninScreen extends StatefulWidget {
  static const String routeName = '/signin';
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<SigninScreen> {
  final AuthService authService = AuthService();
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _regNoController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signInUser() {
    print("sign in method called in Ui");
    authService.signInUser(
      context: context,
      registrationNo: _regNoController.text,
      password: _passwordController.text,
    );
  }

  static const IconData local_gas_station_rounded =
      IconData(0xf86d, fontFamily: 'MaterialIcons');

  final _formKey = GlobalKey<FormState>();


  Station station = Station('', '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset(
              'assets/wave.svg',
              width: 400,
              height: 200,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Fast Fueler",
                        style: GoogleFonts.pacifico(
                            fontWeight: FontWeight.bold,
                            fontSize: 38,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      Icon(
                        local_gas_station_rounded,
                        size: 40,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Fuel Station Login",
                    style: GoogleFonts.signikaNegative(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 17, 17, 17)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _regNoController,
                      onChanged: (value) {
                        station.registrationNo = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Registration Number';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.business,
                            size: 30,
                            color: Color.fromARGB(255, 20, 20, 20),
                          ),
                          hintText: 'Enter Registration Number',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 20, 20, 20))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 20, 20, 20))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _passwordController,
                      onChanged: (value) {
                        station.password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the Password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            size: 30,
                            color: Color.fromARGB(255, 20, 20, 20),
                          ),
                          hintText: 'Enter Password',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 20, 20, 20))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 20, 20, 20))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.red))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(60, 16, 16, 0),
                    child: Container(
                      height: 50,
                      width: 400,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 58, 166, 185)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signInUser();
                            } else {
                              print("not ok");
                            }
                          },
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
