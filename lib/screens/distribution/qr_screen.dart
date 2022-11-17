import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScreen extends StatefulWidget {
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
              builder: (context) => FoundCodeScreen(
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

  // void _foundBarcode(Barcode barcode, MobileScannerArguments? args) {
  //   /// open screen
  //   if (!_screenOpened) {
  //     final String code = barcode.rawValue ?? "---";
  //     debugPrint('Barcode found! $code');
  //     _screenOpened = true;
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) =>
  //               FoundCodeScreen(screenClosed: _screenWasClosed, value: code),
  //         ));
  //   }
  // }

  // void _screenWasClosed() {
  //   _screenOpened = false;
  // }
}

class FoundCodeScreen extends StatefulWidget {
  final Barcode value;
  final Function() screenClosed;
  const FoundCodeScreen({
    Key? key,
    required this.value,
    required this.screenClosed,
  }) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Found Code"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Scanned Code:",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "my code: ${widget.value.code}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
