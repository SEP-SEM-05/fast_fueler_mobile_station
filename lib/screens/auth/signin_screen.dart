import 'package:fast_fueler_mobile_station/screens/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninScreen extends StatefulWidget {
  static const String routeName = '/signin';
  const SigninScreen({Key? key}) : super(key: key);

  @override
  SigninState createState() => SigninState();
}

class SigninState extends State<SigninScreen> {
  final AuthService authService = AuthService();
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _regNoController.dispose();
    _passwordController.dispose();
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      registrationNo: _regNoController.text,
      password: _passwordController.text,
    );
  }

  final _formKey = GlobalKey<FormState>();

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
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      const Icon(
                        Icons.local_gas_station_rounded,
                        size: 40,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Fuel Station Login",
                    style: GoogleFonts.signikaNegative(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: const Color.fromARGB(255, 17, 17, 17)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _regNoController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Registration Number';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          icon: const Icon(
                            Icons.business,
                            size: 30,
                            color: Color.fromARGB(255, 20, 20, 20),
                          ),
                          hintText: 'Registration Number',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 20, 20, 20))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 20, 20, 20))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.red))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the Password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: const Icon(
                            Icons.vpn_key,
                            size: 30,
                            color: Color.fromARGB(255, 20, 20, 20),
                          ),
                          hintText: 'Password',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 20, 20, 20))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 20, 20, 20))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.red))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 16, 16, 0),
                    child: SizedBox(
                      height: 50,
                      width: 400,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 58, 166, 185)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signInUser();
                            } else {
                              debugPrint("not ok");
                            }
                          },
                          child: const Text(
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
