import 'package:fast_fueler_mobile_station/screens/distribution/distribution_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScreen extends StatefulWidget {
  static const String routeName = '/qr-reade';

  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool _screenOpened = false;

  @override
  void initState() {
    super.initState();
    _screenOpened = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
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
          actions: [
            IconButton(
              color: Colors.white,
              icon: FutureBuilder(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    return snapshot.data == true
                        ? const Icon(Icons.flash_on, color: Colors.yellow)
                        : const Icon(Icons.flash_off, color: Colors.grey);
                  }),
              iconSize: 28.0,
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
            ),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.flip_camera_ios_rounded),
              iconSize: 28.0,
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
            ),
          ],
        ),
        body: QRView(
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 250),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          key: qrKey,
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (!_screenOpened) {
        _screenOpened = true;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DistributionScreen(
                  screenClosed: _screenWasClosed, value: scanData),
            ));
      }
      // setState(() {
      //   result = scanData;
      // });
    });
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
